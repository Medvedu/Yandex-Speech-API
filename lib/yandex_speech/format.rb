# encoding: utf-8
# frozen_string_literal: true
module YandexSpeechApi
  class Format

    ##
    # List of allowed formats
    #
    # @return [Array<String>]

    def self.list
      %i(mp3 wav opus)
    end

    # @return [Symbol]
    #   possible values: :mp3, :wav or :opus

    attr_reader :type

    def initialize(format)
      @type = format.downcase.to_sym

      raise FormatNotAllowed, format unless format_known? @type
    end

    private

    def format_known?(format)
      Format.list.include? format
    end

    ##
    # Raised when unknown format has been selected.

    class FormatNotAllowed < YandexSpeechError
      def initialize(format); super "Format '#{format}' not allowed for usage. To see list of allowed formats use Format#list" end; end
  end # class Format
end # module YandexSpeechApi
