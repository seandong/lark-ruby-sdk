module Lark
  module Apis
    module User
      def group_list(user_access_token:, page_size: nil, page_token: nil)
        get 'user/v4/group_list', {
          access_token: user_access_token,
          params: {
            page_size: page_size,
            page_token: page_token
          }
        }.compact
      end

      def batch_get_id(emails: nil, mobiles: nil)
        get 'user/v1/batch_get_id', params: {
          emails: emails,
          mobiles: mobiles
        }.compact
      end
    end
  end
end