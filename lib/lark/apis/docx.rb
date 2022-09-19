module Lark
  module Apis
    module Docx
      def create(user_access_token:, folder_token:, title:)
        post 'docx/v1/documents', {
          folder_token: folder_token, title: title
        }, access_token: user_access_token
      end

      # @param [String] access_token
      # @param [String] document_id
      def get_all_blocks(access_token:, document_id:)
        blocks = []
        page_token = nil
        has_more = true
        while has_more
          r = get_blocks(access_token: access_token, document_id: document_id, page_token: page_token)
          has_more = r.data['data']['has_more']
          page_token = r.data['data']['page_token']
          blocks += r.data['data']['items']
        end
        blocks
      end

      # 删除文档中的块
      # @param [String] access_token  tenant_access_token 或 user_access_token
      # @param [String] document_id   文档 ID
      # @param [String] block_id      父块 ID
      # @param [Int] start_index      删除子块的起始 index
      # @param [Int] end_index        删除子块的结束 index，左闭右开
      def delete_block(access_token:, document_id:, block_id:, start_index:, end_index:)
        delete "docx/v1/documents/#{document_id}/blocks/#{block_id}/children/batch_delete",
               {
                 start_index: start_index,
                 end_index: end_index,
               },
               access_token: access_token
      end

      # @param [String] access_token  tenant_access_token 或 user_access_token
      # @param [String] document_id   文档 ID
      # @param [String] block_id      父块 ID
      def update_block(access_token:, document_id:, block_id:)
        patch "docx/v1/documents/#{document_id}/blocks/#{block_id}",
              {

              },
              access_token: access_token
      end

      # @param [String] access_token  tenant_access_token 或 user_access_token
      # @param [String] document_id   文档 ID
      # @param [String] block_id      父块 ID
      # @param [Object] children      创建的块数组
      def create_blocks(access_token:, document_id:, block_id:, children:, index:)
        post "docx/v1/documents/#{document_id}/blocks/#{block_id}/children", {
          children: children,
          index: index,
        }.compact, access_token: access_token
      end

      private

      # @param [String] access_token
      # @param [String] document_id
      # @param [String] page_token
      def get_blocks(access_token:, document_id:, page_token:)
        get "docx/v1/documents/#{document_id}/blocks",
            params: { page_token: page_token }.compact,
            get_header: { access_token: access_token }
      end
    end
  end
end
