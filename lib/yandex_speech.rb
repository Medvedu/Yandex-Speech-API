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

  # Speaker is a class that convert English, Ukrain, Russian or Turkey text to
  # speech. Solution based on Yandex SpeechKit Cloud technology.
  #
  # @example Basic usage
  #   key = File.open('secret key/key').readline.strip
  #
  #   speaker = YandexSpeechApi::Speaker.new key: key, language: 'russian'
  #   speaker.save_to_file 'Не будите спящего кота.'
  #
  # @example Hash syntax
  #   key = File.open('secret key/key').readline.strip
  #
  #   message = "Don't trouble trouble until trouble troubles you"
  #   speaker = YandexSpeechApi::Speaker.new voice: :zahar, speed: 1.1
  #   speaker.say message
  #
  # @example Block syntax
  #   key = File.open('secret key/key').readline.strip
  #   message = "one two three. one two three. one two three four."
  #
  #   speaker = YandexSpeechApi::Speaker.new do |s|
  #     s.key      = key
  #     s.voice    = :jane
  #     s.language = :english
  #     s.emotion  = :good
  #   end
  #   speaker.say message
  #
  # Before usage you need to get an api key. It is free for non-commercial
  # purposes (at least for now).
  #
  # You can get the key from official site:
  #   https://developer.tech.yandex.ru (SpeechKit Cloud key)

  class << self
    ##
    # Authorization key, overrides Speaker.key when used. Optional.
    #
    # @return [String, NilClass]

    attr_accessor :key
  end # class << self

  class Speaker
    include Setters

    # @return [String, NilClass]

    def key
      YandexSpeechApi.key || @key
    end

    ##
    # Dictor speech speed.
    #
    # @return [Float]
    #   Any from those - (0.1)..3

    attr_reader :speed

    ##
    # Preferred dictor voice.
    #
    # @return [Symbol]
    #  Any from those: :jane, :oksana, :alyss, :omazh, :zahar, :ermil

    attr_reader :voice

    ##
    # How emotional dictor should speak.
    #
    # @return [String]
    #  Any from those: "good", "evil", "neutral"

    attr_reader :emotion

    ##
    # Speaker language.
    #
    #   Speaker with +russian+ language can't translate, or even synthesize
    #   +english+ text (actually it can, but official documentation strongly
    #   recommend to select correct language for text)
    #
    # @return [String]
    #   Any from those: "russian", "english", "ukrain", "turkey"

    attr_reader :language

    ##
    # How remote server should decode audio data for us.
    #
    #   Do not use +:wav+ format for large texts. Result audio file will be
    #   too big, and service truncates resulted file.
    #
    # @return [Symbol]
    #  Any from those: "mp3", "wav", "opus"

    attr_reader :format

    # @param [Proc] callback
    #   Used to set object attributes through {do...end} block.
    #
    # @return [YandexSpeechApi::Speaker]

    def initialize(settings = {}, &callback)
      yield self if block_given?

      self.key = settings[:key]

      self.voice    ||= settings[:voice]    || "jane"
      self.speed    ||= settings[:speed]    || 1.0
      self.emotion  ||= settings[:emotion]  || "good"
      self.language ||= settings[:language] || "english"
      self.format   ||= settings[:format]   || "mp3"
    end

    ##
    # Speaks the text
    #
    # @param [String] text
    #   Something that should been said.
    #
    # @return [NilClass]
    #   You hear the sound.

    def say(text)
      self.format = :mp3
      row_data = request text
      Sounds.play row_data

      return nil
    end

    ##
    # Saves synthesized voice to audio-file.
    #
    # @param [String] text
    #   Something that should been said.
    #
    # @param [String] path_to_file (Dir.pwd)
    #
    # @return [String]
    #   Absolute path to created file.

    def save_to_file(text, path_to_file = '')
      path_to_file = generate_path if path_to_file.empty?

      row_data = request text
      absolute_path = "#{File.expand_path(path_to_file)}.#{format}"
      File.open(absolute_path, 'w') { |f| f.write row_data }

      return absolute_path
    end
  end # class Speaker
end # module YandexSpeechApi
