module Lark
  module Apis
    module Docx
      def create(user_access_token:, folder_token:, title:)
        post 'docx/v1/documents', {
          folder_token: folder_token, title: title
        }, access_token: user_access_token
      end
    end
  end
end
