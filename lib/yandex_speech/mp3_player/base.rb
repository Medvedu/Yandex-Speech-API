# encoding: utf-8
# frozen_string_literal: true
module YandexSpeechApi
module MP3_Player
  class Base # no-doc

    ##
    # Plays sound

    def play(filename)
      @filename = Pathname.new filename
      validate_file_presence
      validate_mp3_format
      validate_requirements
      play_mp3
    end

    private

    attr_reader :filename # no-doc

    ##
    # no-doc

    def validate_file_presence
      raise FileNotFound, filename unless @filename.file?
    end

    ##
    # Raises an exception if +filename+ without '.mp3' extension

    def validate_mp3_format
      unless File.extname(filename).casecmp('.mp3').zero?
        raise UnknownExtension, filename
      end
    end

    ##
    # Play mp3
    #
    # @exception NotImplementedError
    #   raised if #play_mp3 was called, but not overridden in any MP3_Player child

    def play_mp3
      raise NotImplementedError, "Abstract class called"
    end

    ##
    # Validates OS requirements. Abstract
    #
    # @exception NotImplementedError
    #   raised if #validate_requirements was called, but not overridden in any MP3_Player child

    def validate_requirements
      raise NotImplementedError, "Abstract class called"
    end

    ##
    # Raised when +filename+ has wrong (not mp3) extension. Used to give
    # minimal protection against files with unknown format.

    class UnknownExtension < YandexSpeechError
      def initialize(filename); super "Mp3 player can work only with files with '.mp3' extension. Please change extension for #{filename} if you sure that format is correct!'" end; end

    ##
    # Raised when file not found

    class FileNotFound < YandexSpeechError
      def initialize(file); super "File #{file} not found!" end; end
 end # class Base
end # module MP3_Player
end # module YandexSpeechApi
