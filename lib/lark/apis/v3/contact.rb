#
# All apis contain params as below
#   user_id_type
#     可选值：open_id、union_id、user_id
#     默认：open_id
#   department_id_type
#     可选值：department_id、open_department_id
#     默认：open_department_id
#
module Lark
  module Apis
    module V3
      module Contact
        # Scope
        def scopes(user_id_type: nil, department_id_type: nil, page_token: nil, page_size: nil)
          get 'contact/v3/scopes', params: {
            user_id_type: user_id_type,
            department_id_type: department_id_type,
            page_size: page_size,
            page_token: page_token
          }.compact
        end

        # User
        def user(user_id, user_id_type: nil, department_id_type: nil)
          get "contact/v3/users/#{user_id}", params: {
            user_id_type: user_id_type,
            department_id_type: department_id_type
          }.compact
        end

        # page_size 默认：50
        def users_find_by_department(department_id, user_id_type:, department_id_type:, page_size: nil, page_token: nil)
          get 'contact/v3/users/find_by_department', params: {
            department_id: department_id,
            user_id_type: user_id_type,
            department_id_type: department_id_type,
            page_size: page_size,
            page_token: page_token
          }.compact
        end

        # Department
        def department(department_id, user_id_type: nil, department_id_type: nil)
          get "contact/v3/departments/#{department_id}", params: {
            user_id_type: user_id_type,
            department_id_type: department_id_type
          }.compact
        end

        # fetch_child 是否递归获取子部门信息
        def department_children(department_id, user_id_type:, department_id_type:, fetch_child: nil, page_size: nil, page_token: nil)
          get "contact/v3/departments/#{department_id}/children", params: {
            user_id_type: user_id_type,
            department_id_type: department_id_type,
            fetch_child: fetch_child,
            page_size: page_size,
            page_token: page_token
          }.compact
        end
      end
    end
  end
end
