require "fast_gettext"

module Pirate
  module Service
    class Base
      include FastGettext::Translation

      # @return [Hash, Nil]

      attr_reader :attributes

      # Initialize a service and automatically populate instance vars if
      # attr_readers have been defined.

      def initialize(attrs = {})
        @attributes = attrs

        # Set values where we have defined a reader, probably
        @attributes.each do |key, val|
          if respond_to?(key.to_sym)
            instance_variable_set("@#{key}", val)
          end
        end
      end

      # A class method shortcut to instantiating a service and calling it.

      def self.call(*args, &block)
        instance = new(*args)
        instance.call(&block)
      end
    end

    class Error < StandardError; end
    class AuthenticationError < Error; end
  end
end
