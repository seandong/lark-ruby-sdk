module Lark
  module Apis
    module Contact
      def scope_get
        get 'contact/v1/scope/get'
      end

      def department_add(payload={})
        post 'contact/v1/department/add', payload
      end
    end
  end
end