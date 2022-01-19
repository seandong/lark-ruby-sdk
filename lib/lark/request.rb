require 'http'

module Lark
  class Request
    RETRY_OPTIONS = {
      max_tries: 3,
      base_sleep_seconds: 0.5,
      max_sleep_seconds: 1.0,
      rescue: [Lark::InternalErrorException, HTTP::TimeoutError]
    }.freeze

    attr_reader :ssl_context, :http

    def initialize(skip_verify_ssl = true)
      @http = HTTP.timeout(**Lark.http_timeout_options)
      @ssl_context = OpenSSL::SSL::SSLContext.new
      #@ssl_context.ssl_version = :TLSv1_2
      @ssl_context.verify_mode = OpenSSL::SSL::VERIFY_NONE if skip_verify_ssl
    end

    def get(path, get_header = {})
      request(path, get_header) do |url, header|
        params = header.delete(:params)
        http.headers(header).get(url, params: params, ssl_context: ssl_context)
      end
    end
    alias delete get

    def post(path, post_body, post_header = {})
      request(path, post_header) do |url, header|
        Lark.logger.info "payload: #{post_body}"
        params = header.delete(:params)
        http.headers(header).post(url, params: params, json: post_body, ssl_context: ssl_context)
      end
    end

    def post_form(path, form_data, post_header = {})
      request(path, post_header) do |url, header|
        header.delete(:params)
        http.headers(header).post(
          url,
          form: HTTP::FormData::Multipart.new(form_data),
          ssl_context: ssl_context
        )
      end
    end

    private

    def request(path, header = {}, &_block)
      url = URI.join(Lark.api_base_url, path)
      as = header.delete(:as)
      header['Accept'] = 'application/json'

      with_retries RETRY_OPTIONS do |attempts|
        request_uuid = SecureRandom.uuid
        header['X-Request-ID'] = request_uuid

        Lark.logger.info "[#{request_uuid}] request url(#{url}) with headers: #{header}, attempts: #{attempts}"
        response = yield(url, header)
        Lark.logger.info "[#{request_uuid}] response headers: #{response.headers.inspect}"
        unless response.status.success?
          Lark.logger.error "[#{request_uuid}] request #{url} happen error: #{response.body}"
          raise ResponseError.new(response.status, response.body)
        end
        handle_response(response, as || :json)
      end
    end

    def handle_response(response, as)
      content_type = response.headers[:content_type]
      parse_as = {
        %r{^application\/json} => :json,
        %r{^image\/.*} => :file
      }.each_with_object([]) { |match, memo| memo << match[1] if content_type =~ match[0] }.first || as || :text

      body = response.body
      case parse_as
      when :file
        parse_as_file(body)
      when :json
        parse_as_json(body)
      else
        body
      end
    end

    def parse_as_json(body)
      Lark.logger.info "response body: #{body}"
      data = JSON.parse body.to_s
      result = Result.new(data)
      raise ::Lark::AccessTokenExpiredError if result.access_token_expired?
      raise ::Lark::InternalErrorException if result.internal_error?

      result
    end

    def parse_as_file(body)
      file = Tempfile.new('tmp')
      file.binmode
      file.write(body)
      file.close

      file
    end
  end

  class Result
    attr_reader :code, :data

    def initialize(data)
      @code = data['code'].to_i
      @data = data
    end

    def access_token_expired?
      [99_991_663, 99_991_664].include?(code)
    end

    def internal_error?
      [2_200, 1_061_001, 1_061_006, 1_061_045].include?(code)
    end

    def success?
      code.zero?
    end
  end
end
