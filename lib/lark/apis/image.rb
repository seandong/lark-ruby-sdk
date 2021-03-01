module Lark
  module Apis
    module Image
      def upload(image, image_type)
        post_file 'image/v4/put/', image, params: { image_type: image_type }
      end

      def download(image_key, params = {})
        get 'image/v4/get', params: params.merge(image_key: image_key), as: :file
      end
    end
  end
end