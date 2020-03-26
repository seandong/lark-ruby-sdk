module Lark
  module Apis
    module Mina
      def token_login_validate(code)
        request.post 'mina/v2/tokenLoginValidate', {
          code: code,
          token: app_access_token
        }
      end
    end
  end
end