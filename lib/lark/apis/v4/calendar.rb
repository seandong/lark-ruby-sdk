module Lark
  module Apis
    module V4
      module Calendar
        def list(user_access_token: nil, page_size: nil, page_token: nil, sync_token: nil)
          get 'calendar/v4/calendars', {
            access_token: user_access_token,
            params: {
              page_size: page_size,
              page_token: page_token,
              sync_token: sync_token
            }.compact
          }
        end

        def get(calendar_id, user_access_token: nil)
          get "calendar/v4/calendars/#{calendar_id}", {
            access_token: user_access_token
          }
        end

        def search(query, page_size: nil, page_token: nil)
          post 'calendar/v4/calendars/search', { query: query }, {
            params: {
              page_size: page_size,
              page_token: page_token
            }.compact
          }
        end

        def create(summary:, user_access_token: nil, description: nil, permissions: nil, color: nil, summary_alias: nil)
          post 'calendar/v4/calendars', {
            summary: summary,
            description: description,
            permissions: permissions,
            color: color,
            summary_alias: summary_alias
          }.compact, access_token: user_access_token
        end

        def create_event(calendar_id:, user_access_token: nil, payload: {})
          post "calendar/v4/calendars/#{calendar_id}/events", payload, access_token: user_access_token
        end
      end
    end
  end
end
