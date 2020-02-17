module Lark
  module Route
    extend ActiveSupport::Concern

    module ClassMethods
      def mount(name)
        class_eval <<-CODE, __FILE__, __LINE__ + 1
          def #{name}
            @#{name} ||= Class.new(SimpleDelegator) do
              include Apis::#{name.to_s.classify}
            end.new(self)
          end
        CODE
      end
    end
  end
end