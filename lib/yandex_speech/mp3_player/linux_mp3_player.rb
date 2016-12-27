# encoding: utf-8
# frozen_string_literal: true
module YandexSpeechApi
module MP3_Player
  class Linux_MP3_Player < MP3_Player::Base # no-doc
    private

    # @return [String]
    #   Path to +mpg123+ application

    attr_reader :path_to_executable

    ##
    # Check requirements.
    #
    # @exception ApplicationNotInstalled
    #   Raised if +mpg123+ not found.

    def validate_requirements
      @path_to_executable = Helpers::find_executable 'mpg123'

      if path_to_executable.nil?
        raise ApplicationNotInstalled , 'mpq123'
      end
    end

    ##
    # no-doc

    def play_mp3
      `#{path_to_executable} -q '#{filename}'`
    end

    ##
    # Raised when necessary linux program not found.

    class ApplicationNotInstalled < YandexSpeechError
      def initialize(name); super "Program '#{name}' not found!" end; end
    end # class Linux_MP3_Player
end # module MP3_Player
end # module YandexSpeechApi
