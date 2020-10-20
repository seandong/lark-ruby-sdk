module Lark
  module Apis
    module Application
      def app_admin_user_list
        get 'user/v4/app_admin_user/list'
      end

      def is_user_admin(params={})
        get 'application/v3/is_user_admin', params: params
      end

      def app_visibility(app_id:, user_page_token: nil, user_page_size: nil)
        get 'application/v1/app/visibility', params: {
          app_id: app_id,
          user_page_token: user_page_token,
          user_page_size: user_page_size
        }.compact
      end

      def user_visible_apps(params={})
        get 'application/v1/user/visible_apps', params: params
      end

      def app_list(params={})
        get 'application/v3/app/list', params: params
      end

      def app_update_visibility(payload={})
        post 'application/v3/app/update_visibility', payload
      end
    end
  end
end