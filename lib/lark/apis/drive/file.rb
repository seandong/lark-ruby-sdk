module Lark
  module Apis
    module Drive
      module File
        def create(user_access_token:, folder_token:, title:, type:)
          post "drive/explorer/v2/file/#{folder_token}",
               { title: title, type: type },
               access_token: user_access_token
        end

        def copy(user_access_token:, file_token:, payload:)
          post "drive/explorer/v2/file/copy/files/#{file_token}",
               payload,
               access_token: user_access_token
        end

        def delete_doc(user_access_token:, token:)
          delete "drive/explorer/v2/file/docs/#{token}",
                 access_token: user_access_token
        end

        def delete_sheet(user_access_token:, token:)
          delete "drive/explorer/v2/file/spreadsheets/#{token}",
                 access_token: user_access_token
        end
      end
    end
  end
end
