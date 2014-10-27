module Virtus
  class Attribute

    module LazyCoercible

      def get(instance)
        coerce(super)
      end

      def set(instance, value)
        super
      end

    end
  end
end

