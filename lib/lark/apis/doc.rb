module Lark
  module Apis
    module Doc
      def create(user_access_token:, folder_token:, content: {})
        post 'doc/v2/create', {
          FolderToken: folder_token, Content: content
        }, access_token: user_access_token
      end
    end
  end
end
