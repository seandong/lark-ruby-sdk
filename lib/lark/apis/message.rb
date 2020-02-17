module Lark
  module Apis
    module Message
      def send(payload)
        post 'message/v4/send/', payload
      end
    end
  end
end