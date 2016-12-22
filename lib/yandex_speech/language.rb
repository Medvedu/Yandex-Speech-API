# encoding: utf-8
# frozen_string_literal: true
module YandexSpeechApi
  class Language # no-doc

    ##
    # List of allowed languages
    #
    # @return [Array<Classes>]

    def self.allowed_languages
      @cached_list ||= Array(codes.keys)
    end

    def self.codes # no-doc
      {
        english: 'en-US',
        russian: 'ru‑RU',
        turkey:  'tr-TR',
        ukrain:  'uk-UK',
      }
    end

    # @return [Symbol]

    attr_reader :language

    # @return [String]

    def code
      @code ||= Language.codes[@language]
    end

    ##
    # Creates new object instance.
    #
    # @param [String] language
    #   Selected language.
    #
    # @exception UnknownLanguageError
    #   Raised when language is unknown
    #
    # @return [Language]

    def initialize(language)
      @language = language.downcase.to_sym

      unless Language.allowed_languages.include? @language
        raise UnknownLanguageError, @language
      end
    end

    ##
    # Raised when unknown language has been selected.

    class UnknownLanguageError < YandexSpeechError
      def initialize(lang); super "Unknown language selected: '#{lang}'. See Language#allowed_languages for list of allowed languages" end; end
  end # class Language
end # module YandexSpeechApi
