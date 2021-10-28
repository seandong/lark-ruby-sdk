require 'lark/token_store/base'

module Lark
  module TokenStore
    class JsapiTicket < Base
      def token_key
        'ticket'
      end

      def fetch_token
        client.jssdk.ticket_get
      end

      def redis_key
        @redis_key ||= Digest::MD5.hexdigest "#{self.class.name}_#{client.app_id}_#{client.tenant_key}"
      end
    end
  end
end
