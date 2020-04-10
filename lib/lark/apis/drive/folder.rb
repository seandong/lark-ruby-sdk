module Lark
  module Apis
    module Drive
      module Folder
        def create(user_access_token:, folder_token:, title:)
          post "drive/explorer/v2/folder/#{folder_token}",
               { title: title },
               access_token: user_access_token
        end

        def meta(user_access_token:, folder_token:)
          get "drive/explorer/v2/folder/#{folder_token}/meta",
              access_token: user_access_token
        end

        def root_meta(user_access_token:)
          get 'drive/explorer/v2/root_folder/meta',
              access_token: user_access_token
        end

        def children(user_access_token:, folder_token:, types: nil)
          get "drive/explorer/v2/folder/#{folder_token}/children",
              access_token: user_access_token,
              params: { types: types }.compact
        end
      end
    end
  end
end
