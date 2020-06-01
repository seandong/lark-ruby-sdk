module Lark
  module Apis
    module Interactive
      def card_update(token:, card:)
        post 'interactive/v1/card/update', {
          token: token,
          card: card
        }
      end
    end
  end
end
