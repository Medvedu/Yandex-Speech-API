# encoding: utf-8
# frozen_string_literal: true
#
# Wrapper for Yandex Speech API (https://tech.yandex.ru/speechkit).
#
module YandexSpeechApi
  require_relative 'yandex_speech/project_structure'
  #
  # Speaker a class that convert English, Ukrain, Russian or Turkey text to
  # speech. Solution based on Yandex SpeechKit technology.
  #
  # @example Usage sample.
  #
  #   require 'yandex_speech'
  #
  #   key = File.open('secret key/key').readline.strip
  #
  #   speaker = YandexSpeechApi::Speaker.init key: key
  #   speaker.save_to_file "Не будите спящего кота."
  #
  #
  # @example Hash syntax
  #
  #   require 'yandex_speech'
  #
  #   key = File.open('secret key/key').readline.strip
  #   message = "Don't trouble trouble until trouble troubles you"
  #
  #   speaker = YandexSpeechApi::Speaker.init({ key: key, language: 'english', voice: :zahar, speed: 0.23 })
  #   speaker.say message
  #
  # @note
  #
  #   Before usage you should get your key. It is free for non-commercial
  #   purposes (at least for now).
  #
  #   You can get this key from official site: https://tech.yandex.ru/speechkit
  #
  #   Note: Yandex provide many services throw this site. Your need exactly
  #   /Yandex SpeechKit Cloud/ key. Other keys will not work!
  #
  #   Do not share your key to third party.
  #
  class Speaker
    class << self
      ##
      # Creates +Speaker+ instance.
      #
      #
      # @param [HASH] settings that you maybe want to override.
      #
      # @option settings [Symbol] :speed (:standard) see Speaker#speed for details.
      # @option settings [Symbol] :voice (:alyss) see Speaker#voice for details.
      # @option settings [Symbol] :emotion (:neutral) see Speaker#emotion for details.
      # @option settings [Symbol] :language (:russian) Speaker#language for details.
      # @option settings [Symbol] :format (:mp3) Speaker#format for details.
      # @option settings [Symbol] :key (:unknown) Speaker#key for details.
      #
      # @return [YandexSpeech] the speaker object.
      #
      def init(settings = {})
        new default_settings.merge(settings)
      end

      ##
      # Default settings.
      #
      # @return [Hash]
      #
      def default_settings
        {
          key:           :unknown,
          language:      :russian,
          emotion:       :neutral,
          voice:         :alyss,
          format:        :mp3,
          speed:         :standard
        }
      end
    end # class << self

    private_class_method :new
    private_class_method :default_settings

    #
    # ---------- S P E A K E R instance methods ----------
    #

    ##
    # Determines dictor speech speed.
    #
    # @setter #speed=(other)
    #   @param [Symbol, Integer, Float] other
    #   Expecting values are
    #     :slowest, :slow, :standard, :fast, :fastest
    #   or any Integer/Float from 1..3 range.
    #
    # @return [Speed] speed object
    #
    attr_reader :speed

    ##
    # Preferred dictor voice.
    #
    #  female voices: 'jane',  'oksana', 'alyss', 'omazh'
    #  male voice:    'zahar', 'ermil'
    #
    # @setter #voice=(other)
    #   @param [Symbol] other
    #   Expecting values are
    #     :jane, :oksana, :alyss, :omazh, :zahar, :ermil
    #
    # @return [Voice] voice object.
    #
    attr_reader :voice

    ##
    # How emotional dictor should speak.
    #
    # @setter #emotion=(other)
    #   @param [Symbol] other
    #   Expecting values are
    #     :good, :evil, :neutral
    #
    # @return [Emotion] emotion object.
    #
    attr_reader :emotion

    ##
    # Speaker language.
    #
    # @setter #language=(other)
    #   @param [Symbol] other
    #   Expecting values are
    #     :russian, :english, :ukrain, :turkey
    #
    # @note speaker with +russian+ language can't translate, or even synthesize
    # +english+ text (actually it can, but official documentation strongly
    # recommend to select right language for a text)
    #
    # @return [Language] language object.
    #
    attr_reader :language

    ##
    # How remote server should decode audio data for us.
    #
    # @setter #format=(other)
    #   @param [Symbol] other
    #   Expecting values are
    #     :mp3, :wav, :opus
    #
    # @note do not use +:wav+ format for large texts. Result audio file will be
    # soo big and Yandex truncates those texts.
    #
    # @return [Format] format object.
    #
    attr_reader :format

    #
    # Runtime defines setters for +@voice+, +@language+,+@format+, +@emotion+,
    # +@speed+, +@key+ attributes.
    #
    %i(voice language format emotion speed key).each do |symbol|
      define_method "#{symbol}=" do |other|
        method_name = __method__.to_s.chop
        klass = YandexSpeechApi.const_get method_name.capitalize
        variable =
          if other.is_a? klass
            other
          else
            klass.respond_to?(:init) ? klass.init(other) : klass.new(other)
          end
        instance_variable_set "@#{method_name}", variable
      end
    end

    ##
    # Speeches text.
    #
    # @param [String] text something that should been said.
    #
    # @return: You hear the voice. o_0
    #
    def say(text)
      format = Format.new :mp3
      binary_data = request text, format: format

      tmp_filename = "#{File.expand_path('temporary')}.#{format.type}"
      File.open(tmp_filename, 'w') { |f| f.write binary_data }

      player = MP3_Player.init
      player.play tmp_filename

      File.delete tmp_filename
    end

    ##
    # Saves synthesized voice to file.
    #
    # @param [String] text something that should been said.
    # @param [String] filename ('temporary') path to file (without file extension)
    #
    # @return:
    #
    def save_to_file(text, filename = 'temporary')
      binary_data = request text

      tmp_filename = "#{File.expand_path(filename)}.#{format.type}"
      File.open(tmp_filename, 'w') { |f| f.write binary_data }

      tmp_filename.to_s
    end

    private

    ##
    # Yandex Speech ApiKey.
    #
    # Key is not something that should be shared with any other
    # class. Setter method still available to call from public zone thought.
    #
    # @setter #key=(new_key)
    #   @param [String] new_key
    #
    # @return [Key] key object.
    #
    attr_reader :key
  end # class Speaker
end # module YandexSpeechApi
