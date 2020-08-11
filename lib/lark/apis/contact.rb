module Lark
  module Apis
    module Contact
      def scope_get
        get 'contact/v1/scope/get'
      end

      def department_add(payload={})
        post 'contact/v1/department/add', payload
      end

      def department_batch_add(payload={})
        post 'contact/v2/department/batch_add', payload
      end

      def department_delete(department_id)
        post 'contact/v1/department/delete', {id: department_id}
      end

      def department_update(payload={})
        post 'contact/v1/department/update', payload
      end

      def department_get(department_id)
        get 'contact/v1/department/info/get', params: {department_id: department_id}
      end

      def department_children(department_id:, offset:, page_size:, fetch_child: false)
        get 'contact/v1/department/simple/list', params: {
          department_id: department_id,
          offset: offset,
          page_size: page_size,
          fetch_child: fetch_child
        }.compact
      end

      def department_children_ids(department_id)
        get 'contact/v1/department/list', params: {department_id: department_id}
      end

      def department_batch_get(department_ids=[])
        get 'contact/v1/department/detail/batch_get', params: {department_ids: department_ids}
      end

      def department_user_list(department_id:, offset: nil, page_token: nil, page_size:, fetch_child: false)
        get 'contact/v1/department/user/list', params: {
          department_id: department_id,
          offset: offset, # deprecation
          page_token: page_token,
          page_size: page_size,
          fetch_child: fetch_child
        }.compact
      end

      def department_user_detail_list(department_id:, offset: nil, page_token: nil, page_size:, fetch_child: false)
        get 'contact/v1/department/user/detail/list', params: {
          department_id: department_id,
          offset: offset, # deprecation
          page_token: page_token,
          page_size: page_size,
          fetch_child: fetch_child
        }.compact
      end

      def user_add(payload={})
        post 'contact/v1/user/add', payload
      end

      def user_batch_add(payload={})
        post 'contact/v2/user/batch_add', payload
      end

      def user_delete(payload={})
        post 'contact/v1/user/delete', payload
      end

      def user_update(payload={})
        post 'contact/v1/user/update', payload
      end

      def user_batch_get(params={})
        get 'contact/v1/user/batch_get', params: params
      end

      def tenant_custom_attr_get
        get 'contact/v1/tenant/custom_attr/get'
      end

      def task_get(task_id)
        get 'contact/v2/task/get', params: {task_id: task_id}
      end

      def user_admin_scope_get(params)
        get 'contact/v1/user/admin_scope/get', params: params
      end

      def role_list
        get 'contact/v2/role/list'
      end

      def role_members(role_id:, page_token: nil, page_size: nil)
        get 'contact/v2/role/members', params: {
          role_id: role_id,
          page_token: page_token,
          page_size: page_size
        }.compact
      end
    end
  end
end
