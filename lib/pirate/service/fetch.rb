module Pirate
  module Service
    class Fetch < Base
      attr_reader :id
      attr_reader :record

      def call
        before_find
        find_record
        after_find
        return record
      end

      private

      def klass
      end

      # Fetch a record via the identity cache

      def find_record
        @record = klass.fetch(id)
      end

      # Hooks
      # These can be overwritten when inheriting from this class to
      # modify the data around the fetch

      def before_find
      end

      def after_find
      end
    end
  end
end
