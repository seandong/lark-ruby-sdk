module Lark
  module Apis
    module Notify
      def app_notify(payload)
        post 'notify/v4/appnotify', payload
      end
    end
  end
end
