# feishu block api https://bytedance.feishu.cn/docs/doccnicz7ACWPDR0TPGxRhvnBUf#IN6ZZa
module Lark
  module Apis
    class Block
      # 创建block https://bytedance.feishu.cn/docs/doccnicz7ACWPDR0TPGxRhvnBUf#85lcHj
      # params: block_type_id, source_meta(hash), source_data(hash)
      def create_block_entity(block_type_id, source_meta, source_data)
        payload = { Entity: {
          blockTypeID: block_type_id,
          sourceMeta: source_meta.to_json,
          sourceData: source_data.to_json
        } }
        post 'block/server/api/back-end/CreateBlockEntity', payload
      end

      # 推送数据更新 https://bytedance.feishu.cn/docs/doccnicz7ACWPDR0TPGxRhvnBUf#9dAo2X
      # params: version(integer), block_id , block_type_id, source_data(hash)
      def receive_open_block_entity_command(version, block_id, block_type_id, source_data)
        payload = {
          Header: {
            Version: version,
            Action: 'update'
          },
          Data: {
            blockID: block_id,
            blockTypeID: block_type_id,
            sourceData: source_data.to_json
          }
        }

        post 'block/server/api/back-end/ReceiveOpenBlockEntityCommand', payload
      end
    end
  end
end
