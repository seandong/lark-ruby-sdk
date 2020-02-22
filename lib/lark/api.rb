require 'lark/request'

module Lark
  class Api
    include Helper
    include Apis::Message
    include Apis::Chat

    api_mount :auth
    api_mount :authen
    api_mount :contact
    api_mount :user
    api_mount :application
    api_mount :pay
    api_mount :chat
    api_mount :bot
    api_mount :message
    api_mount :image

    attr_reader :app_id, :app_secret, :tenant_key, :isv, :options

    def initialize options={}
      @app_id = options.delete(:app_id) || Lark.app_id
      @app_secret = options.delete(:app_secret) || Lark.app_secret
      @tenant_key = options.delete(:tenant_key)
      @isv = options.delete(:isv) || Lark.isv
      @options = options
    end

    def valid?
      app_token_store.valid? && tenant_token_store.valid?
    end

    def request
      @request ||= Lark::Request.new(false)
    end

    def get(path, headers={})
      with_token(headers) do |headers|
        request.get path, headers
      end
    end

    def post(path, payload, headers={})
      with_token(headers) do |headers|
        request.post path, payload, headers
      end
    end

    def post_file(path, file, headers={})
      with_token(headers) do |headers|
        request.post_file path, file, headers
      end
    end

    def app_ticket= ticket
      Lark.redis.set "APP_TICKET_#{app_id}", ticket
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

    private

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

    def with_token(headers, tries=2)
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
  end
end