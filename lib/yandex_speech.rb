# encoding: utf-8

#
# Wrapper for Yandex Speech API (https://tech.yandex.ru/speechkit/) written on ruby.
#
module YandexSpeechApi
  require_relative 'yandex_speech/project_structure'

  #
  # All work with this lib going throw YandexSpeech class
  #
  class Speaker
    #
    # Constructor #init. Allowing to create new speaker instance
    #
    # input:
    #
    #   +params+ [HASH] list of
    #
    #
    # output:
    #
    #   [YandexSpeech instance]
    #
    # notes:
    #
    # +text+ length limited: only 2000 chars per one request.
    #
    def self.init(settings = {})
      new default_settings.merge(settings)
    end

    #
    # Do not call #new directly.
    #
    private_class_method :new

    private

    #
    #
    #
    def self.default_settings
     {
      language:      :russian,
      sound_quality: :normal
     }
    end
  end # class Speaker
end # module YandexSpeechApi

speaker = YandexSpeechApi::Speaker.init

# speaker.voice =
# speaker.sound_quality

