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

        def upload_all(user_access_token:, file_name:, parent_node:, size:, file:, parent_type: :explorer)
          form_data = HTTP::FormData::Multipart.new(file_name: file_name, parent_type: parent_type, parent_node: parent_node, size: size, file: file)
          post_form "drive/v1/files/upload_all",
                    form_data,
                    access_token: user_access_token
        end

        def upload_prepare(user_access_token:, file_name:, parent_node:, size:, parent_type: :explorer)
          post "drive/v1/files/upload_prepare",
               { file_name: file_name, parent_type: parent_type, parent_node: parent_node, size: size },
               access_token: user_access_token
        end

        def upload_part(user_access_token:, upload_id:, seq:, size:, file:)
          form_data = HTTP::FormData::Multipart.new(upload_id: upload_id, seq: seq, size: size, file: file)
          post_form "drive/v1/files/upload_part",
                     form_data,
                     access_token: user_access_token
        end

        def upload_finish(user_access_token:, upload_id:, block_num:)
          post "drive/v1/files/upload_finish",
               { upload_id: upload_id, block_num: block_num },
               access_token: user_access_token
        end
      end
    end
  end
end
