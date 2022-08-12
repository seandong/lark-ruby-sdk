module Lark
  module Apis
    module V2
      module Block
        def create(title:, block_type_id:, source_data:, source_meta:, version:)
          post 'block/v2/entities', {
            title: title, block_type_id: block_type_id,
            source_data: source_data.to_json, source_meta: source_meta.to_json,
            version: version
          }
        end

        def update(block_id, version:, title: nil, block_type_id:, source_data:, source_meta:)
          put "block/v2/entities/#{block_id}", {
            title: title, block_type_id: block_type_id,
            source_data: source_data.to_json, source_meta: source_meta.to_json,
            version: version
          }.compact
        end
      end
    end
  end
end
