require 'lark/request'

module Lark
  class Api
    include Helper

    api_mount :auth
    api_mount :authen
    api_mount :contact
    api_mount :user
    api_mount :search
    api_mount :application
    api_mount :pay
    api_mount :chat
    api_mount :bot
    api_mount :message
    api_mount :image
    api_mount :doc
    api_mount :mina
    api_mount :notify
    api_mount :interactive
    api_mount :block
    api_mount :approval
    api_mount :'drive/file'
    api_mount :'drive/folder'
    api_mount :'drive/platform'
    api_mount :jssdk

    attr_reader :app_id, :app_secret, :tenant_key, :isv, :options

    def initialize(options = {})
      @app_id = options.delete(:app_id) || Lark.config.default_app_id
      @app_secret = options.delete(:app_secret) || Lark.config.default_app_secret
      raise AppNotConfigException if @app_id.nil? || @app_id.empty?

      @tenant_key = options.delete(:tenant_key)
      @isv = options.key?(:isv) ? options.delete(:isv) : Lark.config.default_isv
      @options = options
    end

    def valid?
      app_token_store.valid? && tenant_token_store.valid?
    end

    def request
      @request ||= Lark::Request.new
    end

    def get(path, headers = {})
      with_token(headers) do |headers_with_token|
        request.get path, headers_with_token
      end
    end

    def post(path, payload = {}, headers = {})
      with_token(headers) do |headers_with_token|
        request.post path, payload, headers_with_token
      end
    end

    def post_form(path, form_data, headers = {})
      with_token(headers) do |headers_with_token|
        request.post_form path, form_data, headers_with_token
      end
    end

    def app_ticket=(new_ticket)
      Lark.redis.set "APP_TICKET_#{app_id}", new_ticket
    end

    def app_ticket
      Lark.redis.get "APP_TICKET_#{app_id}"
    end

    def app_access_token
      app_token_store.token
    end

    def tenant_access_token
      tenant_token_store.token
    end

    def jsapi_ticket
      jsapi_ticket_store.token
    end

    private

    def jsapi_ticket_store
      return @jsapi_ticket_store if defined?(@jsapi_ticket_store)

      @jsapi_ticket_store = TokenStore::JsapiTicket.new(self)
    end

    def app_token_store
      return @app_token_store if defined?(@app_token_store)

      klass = isv ? TokenStore::IsvAppToken : TokenStore::AppToken
      @app_token_store = klass.new(self)
    end

    def tenant_token_store
      return @tenant_token_store if defined?(@tenant_token_store)

      klass = isv ? TokenStore::IsvTenantToken : TokenStore::TenantToken
      @tenant_token_store = klass.new(self)
    end

    def with_token(headers, tries = 2)
      token = headers[:access_token]
      if token.nil?
        via = headers[:via] || 'tenant'
        token = send("#{via}_access_token")
      end
      yield headers.merge(authorization: "Bearer #{token}")
    rescue AccessTokenExpiredError
      send("#{via}_token_store").fetch_token
      retry unless (tries -= 1).zero?
    end

    class << self
      def default
        @default ||= new(
          app_id: Lark.config.default_app_id,
          app_secret: Lark.config.default_app_secret,
          isv: Lark.config.default_isv
        )
      end
    end
  end
end
