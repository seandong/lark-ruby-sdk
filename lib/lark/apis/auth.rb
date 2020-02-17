module Lark
  module Apis
    module Auth
      def app_ticket_resend
        request.post 'auth/v3/app_ticket/resend/', {
          app_id: app_id,
          app_secret: app_secret
        }
      end
    end
  end
end