require 'lark/token_store/base'

module Lark
  module TokenStore
    class IsvTenantToken < Base
      def token_key
        'tenant_access_token'
      end

      def fetch_token
        client.request.post 'auth/v3/tenant_access_token/', {
          app_access_token: client.app_access_token,
          tenant_key: client.tenant_key
        }
      end

      def redis_key
        @redis_key ||= Digest::MD5.hexdigest "#{self.class.name}_#{client.app_id}_#{client.app_secret}_#{client.tenant_key}"
      end
    end
  end
end