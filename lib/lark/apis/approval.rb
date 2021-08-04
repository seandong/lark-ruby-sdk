module Lark
  module Apis
    module Approval
      def get(approval_code, locale='zh-CN')
        post 'https://www.feishu.cn/approval/openapi/v2/approval/get', {approval_code: approval_code, locale: locale}
      end

      def instance_list(payload={})
        post 'https://www.feishu.cn/approval/openapi/v2/approval/get', payload
      end

      def instance_get(approval_code, locale='zh-CN')
        post 'https://www.feishu.cn/approval/openapi/v2/instance/get', {approval_code: approval_code, locale: locale}
      end

      def instance_create(payload={})
        post 'https://www.feishu.cn/approval/openapi/v2/instance/create', payload
      end

      def instance_approve(payload={})
        post 'https://www.feishu.cn/approval/openapi/v2/instance/approve', payload
      end

      def instance_reject(payload={})
        post 'https://www.feishu.cn/approval/openapi/v2/instance/reject', payload
      end

      def instance_transfer(payload={})
        post 'https://www.feishu.cn/approval/openapi/v2/instance/transfer', payload
      end

      def instance_cancel(payload={})
        post 'https://www.feishu.cn/approval/openapi/v2/instance/cancel', payload
      end

      def file_upload(name:, type:, content:)
        post 'https://www.feishu.cn/approval/openapi/v2/file/upload', {
          name: name,
          type: type,
          content: content
        }
      end

      def instance_search(payload={})
        post 'https://www.feishu.cn/approval/openapi/v2/instance/search', payload
      end

      def task_search(payload={})
        post 'https://www.feishu.cn/approval/openapi/v2/task/search', payload
      end

      def cc_search(payload={})
        post 'https://www.feishu.cn/approval/openapi/v2/cc/search', payload
      end

      def instance_cc(payload={})
        post 'https://www.feishu.cn/approval/openapi/v2/instance/cc', payload
      end

      def subscribe(approval_code)
        post 'https://www.feishu.cn/approval/openapi/v2/subscription/subscribe', {approval_code: approval_code}
      end

      def unsubscribe(approval_code)
        post 'https://www.feishu.cn/approval/openapi/v2/subscription/unsubscribe', {approval_code: approval_code}
      end
    end
  end
end