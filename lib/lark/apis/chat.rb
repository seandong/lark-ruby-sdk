module Lark
  module Apis
    module Chat
      def chat_list(params={})
        post 'chat/v4/list', params: params
      end
    end
  end
end