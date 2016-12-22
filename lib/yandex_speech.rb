# encoding: utf-8
# frozen_string_literal: true
#
# Wrapper for Yandex Speech API (https://tech.yandex.ru/speechkit).
#
# @see https://github.com/Medvedu/Yandex-Speech-API
# @see README.md
#
# @author Kuzichev Michael
# @license MIT
module YandexSpeechApi
  require_relative 'yandex_speech/project_structure'
  #
  # Speaker a class that convert English, Ukrain, Russian or Turkey text to
  # speech. Solution based on Yandex SpeechKit technology.
  #
  # @example Basic usage
  #   key = File.open('secret key/key').readline.strip
  #
  #   speaker = YandexSpeechApi::Speaker.init key: key
  #   speaker.save_to_file "Не будите спящего кота."
  #
  # @example Hash syntax
  #   key = File.open('secret key/key').readline.strip
  #   message = "Don't trouble trouble until trouble troubles you"
  #
  #   speaker = YandexSpeechApi::Speaker.init({ key: key, language: 'english', voice: :zahar, speed: 0.23 })
  #   speaker.say message
  #
  # @example Block syntax
  #   key = File.open('secret key/key').readline.strip
  #   message = "one two three. one two three. one two three four."
  #
  #   speaker = YandexSpeechApi::Speaker.init do |s|
  #     s.key      = key
  #     s.voice    = :jane
  #     s.language = :english
  #     s.speed    = :slow
  #     s.emotion  = :good
  #   end
  #   speaker.say message
  #
  # Before usage you need to get an api key. It is free for non-commercial
  # purposes (at least for now).
  #
  # You can get this key from official site: https://tech.yandex.ru/speechkit
  #
  # Note: Yandex provide many services throw this site. Your need exactly
  # +Yandex SpeechKit Cloud+ key. Other keys will not work!
  #
  # Do not share this key to third party.
  #
  class Speaker
    class << self
      ##
      # Creates +Speaker+ instance.
      #
      # @param [Proc] callback
      #   Used to set object state throw {do ... end} block.
      #
      # @param [HASH] settings
      #   Overrides default settings.
      # @option settings [Symbol] :speed (:standard)
      #   @see Speaker#speed for details.
      # @option settings [Symbol] :voice (:alyss)
      #   @see Speaker#voice for details.
      # @option settings [Symbol] :emotion (:neutral)
      #   @see Speaker#emotion for details.
      # @option settings [Symbol] :language (:english)
      #   @see Speaker#language for details.
      # @option settings [Symbol] :format (:mp3)
      #   @see Speaker#format for details.
      # @option settings [Symbol] :key (:unknown)
      #   @see Speaker#key for details.
      #
      # @return [YandexSpeech]

      def init(settings = {}, &callback)
        new settings, &callback
      end
    end # class << self

    private_class_method :new

    ##
    # Determines dictor speech speed.
    #
    # @return [Speed]

    attr_reader :speed

    ##
    # Preferred dictor voice.
    #
    # @return [Voice]

    attr_reader :voice

    ##
    # How emotional dictor should speak.
    #
    # @return [Emotion]

    attr_reader :emotion

    ##
    # Speaker language.
    #
    #   Speaker with +russian+ language can't translate, or even synthesize
    #   +english+ text (actually it can, but official documentation strongly
    #   recommend to select right language for incoming text)
    #
    # @return [Language]

    attr_reader :language

    ##
    # How remote server should decode audio data for us.
    #
    #   Do not use +:wav+ format for large texts. Result audio file will be
    #   too big, and service truncates resulted file.
    #
    # @return [Format]

    attr_reader :format

    ##
    # Defines setters for +@voice+, +@language+,+@format+, +@emotion+,
    # +@speed+, +@key+ attributes.
    #
    # @setter #speed=(other)
    #   @param [Symbol, Integer, Float] other
    #     Expecting values are
    #       :slowest, :slow, :standard, :fast, :fastest
    #       or any Integer/Float from (0.1)..3 range.
    #
    # @setter #voice=(other)
    #   @param [Symbol] other
    #     Expecting values are
    #       :jane, :oksana, :alyss, :omazh, :zahar, :ermil
    #
    # @setter #emotion=(other)
    #   @param [Symbol] other
    #     Expecting values are
    #       :good, :evil, :neutral
    #
    # @setter #language=(other)
    #   @param [Symbol] other
    #     Expecting values are
    #       :russian, :english, :ukrain, :turkey
    #
    # @setter #format=(other)
    #   @param [Symbol] other
    #     Expecting values are
    #       :mp3, :wav, :opus
    #
    # @setter #key=(new_key)
    #   @param [String] new_key

    %i(voice language format emotion speed key).each do |symbol|
      define_method "#{symbol}=" do |other|
        method_name = __method__.to_s.chop
        klass = YandexSpeechApi.const_get method_name.capitalize
        variable =
          if other.is_a? klass
            other
          else
            klass.new(other)
          end
        instance_variable_set "@#{method_name}", variable
      end
    end

    ##
    # Speeches text.
    #
    # @example #Say usage
    #   key = File.open('secret key/key').readline.strip
    #   message = "one two three. one two three. one two three four."
    #
    #   speaker = YandexSpeechApi::Speaker.init do |s|
    #     s.key      = key
    #     s.voice    = :jane
    #     s.language = :english
    #     s.speed    = :slow
    #     s.emotion  = :good
    #   end
    #   speaker.say message
    #
    # @param [String] text
    #   Something that should been said.
    #
    # @return [NilClass]
    #   You hear the sound.

    def say(text)
      format = Format.new :mp3
      binary_data = request text, format: format

      file = Tempfile.new ['yandex_speech_temp_file', ".#{format.type}"]
      file.write binary_data

      player = MP3_Player.init
      player.play file.path

      file.close(true) if file

      return nil
    end

    ##
    # Saves synthesized voice to audio-file.
    #
    # If +path_to_file+ is empty it saves audio-file to '~/downloads'
    #
    # @example #save_to_file usage
    #   key = File.open('secret key/key').readline.strip
    #
    #   speaker = YandexSpeechApi::Speaker.init key: key
    #   speaker.save_to_file "Не будите спящего кота.", 'let_cat_sleep'
    #
    # @param [String] text
    #   Something that should been said.
    #
    # @param [String] path_to_file ('~/downloads')
    #   Path to new file (without file extension).
    #
    # @return [String]
    #   Absolute path to created file.

    def save_to_file(text, path_to_file = '')
      path_to_file = generate_path if path_to_file.empty?

      binary_data = request text
      absolute_path = "#{File.expand_path(path_to_file)}.#{format.type}"
      File.open(absolute_path, 'w') { |f| f.write binary_data }

      return absolute_path
    end

    private

    ##
    # Yandex Speech ApiKey.
    #
    # Key is not something that should be shared with any other class. Setter
    # method is public anyway.
    #
    # @return [Key]

    attr_reader :key
  end # class Speaker
end # module YandexSpeechApi
