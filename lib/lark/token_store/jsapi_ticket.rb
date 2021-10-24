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
    end
  end
end
