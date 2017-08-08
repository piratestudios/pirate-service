module Pirate
  module Service
    module Utilities
      # Utility method for either returning a non-empty collection
      # or returning nil
      #
      # @param [Enumerable] the collection to test
      # @return [Enumerable, Nil]

      def unless_empty(collection)
        return collection unless empty_or_nil?(collection)
      end

      # Shorthand method for checking if something is empty or nil
      #
      # @param [Object] value any value to test against
      # @return [Truthy]

      def empty_or_nil?(value)
        !!(value.nil? || value.try(:empty?))
      end
    end
  end
end
