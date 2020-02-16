require 'lark/token_store/base'

module Lark
  module TokenStore
    class AppToken < Base
      def token_key
        'app_access_token'
      end

      def fetch_token
        client.request.post 'auth/v3/app_access_token/internal/', {
          app_id: client.app_id,
          app_secret: client.app_secret
        }
      end
    end
  end
end