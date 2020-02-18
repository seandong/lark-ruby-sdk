module Lark
  module Apis
    module Bot
      def info
        get 'bot/v3/info/'
      end

      def add(chat_id)
        post 'bot/v3/add', {chat_id: chat_id}
      end

      def remove(chat_id)
        post 'bot/v3/remove', {chat_id: chat_id}
      end
    end
  end
end