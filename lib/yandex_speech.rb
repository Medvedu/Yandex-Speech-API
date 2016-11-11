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
    # Constructor #init. Creates +Speaker+ instance.
    #
    # input:
    #
    #   +settings+ [HASH] list with settings that you maybe want to override.
    #
    # sensible key/value pairs for +settings+ hash are:
    #
    #   settings[:key]            ==> see Speaker#key for details.
    #   settings[:language]       ==> see Speaker#language for details.
    #   settings[:emotion]        ==> see Speaker#emotion for details.
    #   settings[:voice]          ==> see Speaker#voice for details.
    #   settings[:audio_format]   ==> see Speaker#format for details.
    #   settings[:speed]          ==> see Speaker#speed for details.
    #
    # output:
    #
    #   [YandexSpeech instance]
    #
    def self.init(settings = {})
      new default_settings.merge(settings)
    end

    #
    # Do not call #new method directly.
    #
    private_class_method :new

    private

    #
    # output: [HASH] with default settings
    #
    def self.default_settings
     {
      key:           :unknown,
      language:      :russian,
      emotion:       :neutral,
      voice:         :alyss,
      audio_format:  :mp3,
      speed:         :standard
     }
    end
  end # class Speaker
end # module YandexSpeechApi
