# encoding: utf-8
# frozen_string_literal: true
module YandexSpeechApi
  class Format
    #
    # List of all allowed formats:
    #
    def self.list
      %i(mp3 wav opus)
    end

    # ----------------------------------------------------

    #
    # normalized format type
    #
    attr_reader :type

    def initialize(format = :mp3)
      @type = format.downcase.to_sym
      raise FormatNotAllowed, format unless format_known? @type
    end

    private

    def format_known?(format)
      self.class.list.include? format
    end

    #
    # This is supposed to been raised when unknown format has been selected.
    #
    class FormatNotAllowed < StandardError
      def initialize(format); super "Format '#{format}' not allowed for usage. To see list of allowed formats use Format#list" end; end
  end # class Format
end # module YandexSpeechApi
