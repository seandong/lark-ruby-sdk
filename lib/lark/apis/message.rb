module Lark
  module Apis
    module Message
      def message_send(payload)
        post 'message/v4/send/', payload
      end
    end
  end
end