module Lark
  module Apis
    module Drive
      module Platform
        def meta(user_access_token:, request_docs:)
          post 'suite/docs-api/meta',
               { request_docs: request_docs },
               access_token: user_access_token
        end

        def search(user_access_token:, payload: {})
          post 'suite/docs-api/search/object',
               payload,
               access_token: user_access_token
        end
      end
    end
  end
end
