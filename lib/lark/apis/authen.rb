require "erb"

module Lark
  module Apis
    module Authen
      def index(redirect_uri, state)
        uri = ERB::Util.url_encode(redirect_uri)
        "#{URI::join(API_BASE_URL, 'authen/v1/index')}?redirect_uri=#{uri}&app_id=#{app_id}&state=#{state}"
      end

      def access_token(code)
        request.post 'authen/v1/access_token', {
          code: code,
          app_access_token: app_access_token,
          grant_type: 'authorization_code'
        }
      end

      def refresh_access_token(token)
        request.post 'authen/v1/refresh_access_token', {
          refresh_token: token,
          app_access_token: app_access_token,
          grant_type: 'refresh_token'
        }
      end

      def user_info(user_access_token)
        request.get('authen/v1/user_info', params: {user_access_token: user_access_token})
      end
    end
  end
end