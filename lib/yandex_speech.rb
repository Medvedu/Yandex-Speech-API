# encoding: utf-8
# frozen_string_literal: true
#
# Wrapper for Yandex Speech API (https://tech.yandex.ru/speechkit/) written on ruby.
#
module YandexSpeechApi
  require_relative 'yandex_speech/project_structure'
  #
  # Speaker a class that convert english, ukrain, russian or turkey text to
  # speech. This solution based on Yandex SpeechKit technology.
  #
  # How it works? Examples below:
  #
  # Sample 1.
  #
  # encoding: utf-8
  #
  # require_relative '../lib/yandex_speech'
  #
  # key = File.open('secret key/key').readline.strip
  #
  # speaker = YandexSpeechApi::Speaker.init key: key
  # speaker.save_to_file "в 2016 году в 11 месяц в 11 день в 16:55 робо-женщина заговорила.", "wow"
  #
  # ----------------------------------------------------
  #
  # Sample 2.
  #
  # encoding: utf-8
  # require_relative '../lib/yandex_speech'
  #
  # key = File.open('secret key/key').readline.strip
  #
  # message = "Don't trouble trouble until trouble troubles you"
  #
  # speaker = YandexSpeechApi::Speaker.init({ key: key, language: 'english', voice: :zahar, speed: 0.23 })
  # speaker.say message
  #
  # ----------------------------------------------------
  #
  # WARNING!!!
  #
  # Before usage you should get your key. It is free for non-commercial purposes (at least for now).
  #
  # You can get your key from official site: https://tech.yandex.ru/speechkit
  #
  # Do not share this key to third party.
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
       format:        :mp3,
       speed:         :standard
     }
    end
  end # class Speaker
end # module YandexSpeechApi
