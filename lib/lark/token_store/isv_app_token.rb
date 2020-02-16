require 'lark/token_store/base'

module Lark
  module TokenStore
    class IsvAppToken < Base
      def token_key
        'app_access_token'
      end

      def fetch_token
        client.request.post 'auth/v3/app_access_token/', {
          app_id: client.app_id,
          app_secret: client.app_secret,
          app_ticket: client.app_ticket
        }
      end
    end
  end
end