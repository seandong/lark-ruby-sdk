module Lark
  module Apis
    module Jssdk
      def ticket_get
        post 'jssdk/ticket/get'
      end

      def signature_params(url)
        noncestr = SecureRandom.hex(4)
        timestamp = Time.now.to_i
        signature = Digest::SHA1.hexdigest(
          "jsapi_ticket=#{jsapi_ticket}&noncestr=#{noncestr}&timestamp=#{timestamp}&url=#{url}"
        )

        {
          url: url,
          noncestr: noncestr,
          timestamp: timestamp,
          signature: signature
        }
      end
    end
  end
end
