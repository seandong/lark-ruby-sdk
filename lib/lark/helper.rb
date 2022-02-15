module Lark
  module Helper
    extend ActiveSupport::Concern

    included do
      attr_accessor :api_version

      # 调用 api.v3 时，记录字段 api_version 为 v3，并返回 api 本身，api.v3.contact 则会返 api 的 v3_contact 方法
      # 调用 api.contact 这会直接调用 api 的 v1_contact 方法，由此可得：api.contact 与 api.v1.contact 等价
      # 调用 api.xxx 则抛出 method missing 异常
      def method_missing(name, *arguments, &block)
        if api_version.blank?
          if respond_to?("v1_#{name}")
            send("v1_#{name}")
          elsif methods.any? { |m| m.start_with?(name.to_s) }
            self.api_version = name
            self
          else
            super
          end
        elsif respond_to?("#{api_version}_#{name}")
          method_name = "#{api_version}_#{name}"
          self.api_version = nil
          send(method_name)
        else
          self.api_version = nil
          super
        end
      end
    end

    module ClassMethods
      def api_mount(name)
        version = name.to_s =~ /^v\d\/(.)*/ ? nil : 'v1'
        method_name = [version, name.to_s.split('/')].flatten.compact.join('_')
        class_eval <<-CODE, __FILE__, __LINE__ + 1
          def #{method_name}
            @#{method_name} ||= Class.new(SimpleDelegator) do
              include ::Lark::Apis::#{name.to_s.classify}
            end.new(self)
          end
        CODE
      end
    end
  end
end
