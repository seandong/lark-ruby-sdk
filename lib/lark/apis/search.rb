module Lark
  module Apis
    module Search
      def user(query:, user_access_token:, page_size: 20, page_token: nil)
        get 'search/v1/user', {
          access_token: user_access_token,
          params: {
            query: query,
            page_size: page_size,
            page_token: page_token
          }.compact
        }
      end
    end
  end
end