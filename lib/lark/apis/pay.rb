module Lark
  module Apis
    module Pay
      def paid_scope_check_user(open_id: nil, user_id: nil)
        get 'pay/v1/paid_scope/check_user', params: {
          open_id: open_id,
          user_id: user_id
        }.compact
      end

      def order_list(params={})
        get 'pay/v1/order/list', params: params
      end

      def order_get(order_id)
        get 'pay/v1/order/get', params: {order_id: order_id}
      end
    end
  end
end