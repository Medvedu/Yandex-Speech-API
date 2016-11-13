# encoding: utf-8
# frozen_string_literal: true
#
# Wrapper for Yandex Speech API (https://tech.yandex.ru/speechkit).
#
module YandexSpeechApi
  require_relative 'yandex_speech/project_structure'
  #
  # Speaker a class that convert english, ukrain, russian or turkey text to
  # speech. Solution based on Yandex SpeechKit technology.
  #
  # How it works? Examples below:
  #
  # Sample 1.
  #
  # # encoding: utf-8
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
  # # encoding: utf-8
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
  # Before usage you should get your key. It is free for non-commercial
  # purposes (at least for now).
  #
  # You can get your key from official site: https://tech.yandex.ru/speechkit
  #
  # Note: Yandex provide many services throw this site. Your need exactly
  # /Yandex SpeechKit Cloud/ key. Other keys will not work!
  #
  # Do not share your key to third party.
  #
  class Speaker
    class << self
      #
      # Constructor #init. Creates +Speaker+ instance.
      #
      # input:
      #
      #   +settings+ [HASH] list with settings that you maybe want to override.
      #
      # sensible key/value pairs for +settings+ hash are:
      #
      #   settings[:speed]     ==> see Speaker#speed for details.
      #   settings[:voice]     ==> see Speaker#voice for details.
      #   settings[:emotion]   ==> see Speaker#emotion for details.
      #   settings[:language]  ==> see Speaker#language for details.
      #   settings[:format]    ==> see Speaker#format for details.
      #   settings[:key]       ==> see Speaker#key for details.
      #
      # output:
      #
      #   [YandexSpeech instance]
      #
      def init(settings = {})
        new default_settings.merge(settings)
      end

      #
      # output: [HASH] with default settings.
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

    #
    # The #speed method determines dictor speech speed.
    #
    # Allowed speed values:
    #
    # :slowest, :slow, :standard, :fast, :fastest
    #
    # OR
    #
    # (integer/float) number from [1..3] range. Lower number mean
    # slower dictor speech speed.
    #
    attr_reader :speed

    #
    # The #voice method allow to select dictor voice.
    #
    # allowed voices:
    #
    # female: :jane,  :oksana, :alyss, :omazh
    # male:   :zahar, :ermil
    #
    attr_reader :voice

    #
    # The #emotion method determines how emotional dictor should speak.
    #
    # allowed emotions: :good, :evil, :neutral
    #
    attr_reader :emotion

    #
    # The #language method determines speaker language.
    #
    # available languages: :russian, :english, :ukrain, :turkey
    #
    # note: do not use speaker for texts written in different language.
    #
    # It means speaker with +russian+ language can not translate,
    # or even synthesize +english+ text.
    #
    attr_reader :language

    #
    # The #format method determines how remote server should decode
    # audio data for us.
    #
    # Possible audio formats: :mp3, :wav, :opus
    #
    # Note: do not use 'wav' format for large text translation. Result audio
    # file will be to big and Yandex truncates those files.
    #
    attr_reader :format

    #
    # This code defines public setters methods for +@voice+, +@language+,
    # +@format+, +@emotion+ +@speed+, +@key+ attributes.
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

    #
    # The #say method tries to say some +text+
    #
    # input:
    #
    #   text [string] something that should be said.
    #
    # result: if <ok> you hear the voice o_0
    #         if <error> exception
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

    #
    # input:
    #
    #   text     [string] something that should be said.
    #   filename [string] path to file (without file extension)
    #
    # result: if <ok> filename with recorded message
    #         if <error> exception
    #
    # output: filename
    #
    def save_to_file(text, filename = 'temporary')
      binary_data = request text

      tmp_filename = "#{File.expand_path(filename)}.#{format.type}"
      File.open(tmp_filename, 'w') { |f| f.write binary_data }

      tmp_filename.to_s
    end

    private

    #
    # Key is not something that should be shared with any other
    # class. Setter method still available to call from public zone thought.
    #
    attr_reader :key
  end # class Speaker
end # module YandexSpeechApi
