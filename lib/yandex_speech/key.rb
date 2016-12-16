# encoding: utf-8
# frozen_string_literal: true
module YandexSpeechApi
  class Key
    class << self

      ##
      # Sets global key.
      #
      # @param [Key, Symbol] new_key
      #
      # @exception InvalidGlobalKey
      #   raised when +new_key+ param have unexpected class.

      def global_key=(new_key)
        key_tmp = new_key.is_a?(Key) ? new_key : Key.new(new_key)

        raise InvalidGlobalKey, key_tmp unless key_tmp.present?
        @global_key = key_tmp
      end

      ##
      # @return [TrueClass, FalseClass]
      #   true if global key set, otherwise return false.

      def global_key?
        !!global_key
      end

      private

      ##
      # @return [Key, nil]

      def global_key
        @global_key
      end
    end # class << self

    def initialize(key = :unknown)
      @instance_key = key
    end

    ##
    # Returns an key.
    #
    # @exception KeyNotDefined
    #   raised if both +instance key+ and +global key_ are not present
    #
    # @return [Key]

    def get
      if present?
        return instance_key
      elsif default?
        return default.get
      else
        raise KeyNotDefined
      end
    end

    ##
    # Key present?
    #
    # @return [TrueClass, FalseClass]
    #   returns +false+ if key is +:unknown+, otherwise - +true+.

    def present?
      !(instance_key == :unknown)
    end

    private

    # @return [Symbol, String]
    #   possible values: :unknown or some string

    attr_reader :instance_key

    ##
    # @return [TrueClass, FalseClass]
    #   @see Key#global_key?

    def default?
      Key.global_key?
    end

    ##
    # @return [Key, nil]
    #   see Key#global_key

    def default
      Key.instance_variable_get :@global_key
    end

    ##
    # Raised when user tries to call #say method without key.

    class KeyNotDefined < StandardError
      def initialize; super "WARNING! You initialized Speaker class without key! It means you can not use YandexSpeechApi service. You can get your key there: https://tech.yandex.ru/speechkit" end; end

    ##
    # Raised when global key going to be set with default values.

    class InvalidGlobalKey < StandardError
      def initialize(key); super "Global key '#{key}' can not been nil or :unknown" end; end
  end # class Key
end # module YandexSpeechApi
