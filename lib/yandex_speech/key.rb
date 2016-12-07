# encoding: utf-8
# frozen_string_literal: true
module YandexSpeechApi
  class Key
    def self.warn_message
      %w( WARNING! You initialized Speaker class without key! It means you can
          not use YandexSpeechApi service. You can get your key from there:
          https://tech.yandex.ru/speechkit).join ' '
    end

    # ----------------------------------------------------

    #
    # @return [Symbol, String]
    #   possible values: :unknown or some string
    #
    attr_reader :value

    ##
    # Key present?
    #
    # @return [TrueClass, FalseClass]
    #   returns false if key is +:unknown+, otherwise - true.
    #
    def present?
      !(value == :unknown)
    end

    def initialize(key = :unknown)
      @value = key
    end
  end # class Key
end # module YandexSpeechApi
