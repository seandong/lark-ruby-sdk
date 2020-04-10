module Lark
  module Helper
    extend ActiveSupport::Concern

    module ClassMethods
      def api_mount(name)
        class_eval <<-CODE, __FILE__, __LINE__ + 1
          def #{name.gsub('/', '_')}
            @#{name.gsub('/', '_')} ||= Class.new(SimpleDelegator) do
              include Apis::#{name.to_s.classify}
            end.new(self)
          end
        CODE
      end
    end
  end
end
