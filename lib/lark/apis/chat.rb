module Lark
  module Apis
    module Chat
      def members(user_access_token:, chat_id:, page_size: nil, page_token: nil)
        get 'chat/v4/members', {
          access_token: user_access_token,
          params: {
            page_size: page_size,
            page_token: page_token
          }.compact
      end

      def search(user_access_token:, query:, page_size: nil, page_token: nil)
        get 'chat/v4/members', {
          access_token: user_access_token,
          params: {
            access_token: user_access_token,
            query: query,
            page_size: page_size,
            page_token: page_token
          }
        }.compact
      end

      def create(payload={})
        post 'chat/v4/create/', payload
      end

      def list(page_size: nil, page_token: nil)
        get 'chat/v4/list/', params: {
          page_size: page_size,
          page_token: page_token
        }.compact
      end

      def info(chat_id)
        get 'chat/v4/info/', params: {chat_id: chat_id}
      end

      def update(payload={})
        get 'chat/v4/update/', payload
      end

      def chatter_add(chat_id:, user_ids: nil, open_ids: nil)
        post 'chat/v4/chatter/add/', {
          chat_id: chat_id,
          user_ids: user_ids,
          open_ids: open_ids
        }.compact
      end

      def chatter_delete(chat_id:, user_ids: nil, open_ids: nil)
        post 'chat/v4/chatter/delete/', {
          chat_id: chat_id,
          user_ids: user_ids,
          open_ids: open_ids
        }.compact
      end

      def disband(chat_id)
        post 'chat/v4/disband', {chat_id: chat_id}
      end
    end
  end
end