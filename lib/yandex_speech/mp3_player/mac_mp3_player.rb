# encoding: utf-8
# frozen_string_literal: true
module YandexSpeechApi
module MP3_Player
  class Mac_MP3_Player < MP3_Player::Base

    ##
    # no-doc

    def validate_requirements
      nil
    end

    ##
    # no-doc

    def play_mp3
      `afplay '#{filename}'`
    end
  end # class Mac_MP3_Player
end # module MP3_Player
end # module YandexSpeechApi
