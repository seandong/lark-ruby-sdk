module Lark
  module Apis
    module Message
      def batch_send(payload)
        post 'message/v4/batch_send/', payload
      end

      def direct_send(payload)
        post 'message/v4/send/', payload
      end
    end
  end
end