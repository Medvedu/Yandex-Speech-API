# encoding: utf-8
# frozen_string_literal: true
module YandexSpeechApi
  #
  # samples: Voice.new('Oksana') ==> instance of voice object
  #          Voice.new(:bill)    ==> VoiceNotAllowed exception
  #
  class Voice
    #
    # List of all allowed voices:
    #
    def self.list
      %i(jane oksana alyss omazh zahar ermil)
    end

    #
    # normalized voice name
    #
    attr_reader :name

    #
    # constructor
    #
    def initialize(voice)
      @name = voice.downcase.to_sym
      raise VoiceNotAllowed.new voice unless voice_allowed? voice
    end

    private

    def voice_allowed?(name)
      self.class.list.include? name
    end

    class VoiceNotAllowed < StandardError
      def initialize(voice); super "voice '#{voice}' not allowed for usage. To see list of allowed voices use Voice#list" end; end
  end # class Voice
end # module YandexSpeechApi
