# encoding: utf-8
# frozen_string_literal: true
module YandexSpeechApi
  #
  # samples: Voice.new('Oksana') ==> instance of voice class
  #          Voice.new(:bill)    ==> VoiceNotAllowed exception
  #
  class Voice
    #
    # List of all allowed voices:
    #
    def self.list
      %i(jane oksana alyss omazh zahar ermil)
    end

    # ----------------------------------------------------

    #
    # normalized voice name
    #
    attr_reader :name

    def initialize(voice = :jane)
      @name = voice.downcase.to_sym
      raise VoiceNotAllowed, voice unless voice_known? @name
    end

    private

    def voice_known?(name)
      self.class.list.include? name
    end

    #
    # This is supposed to been raised when unknown voice has been selected.
    #
    class VoiceNotAllowed < StandardError
      def initialize(voice); super "Voice '#{voice}' not allowed for usage. To see list of allowed voices use Voice#list" end; end
  end # class Voice
end # module YandexSpeechApi
