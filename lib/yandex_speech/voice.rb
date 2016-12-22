# encoding: utf-8
# frozen_string_literal: true
module YandexSpeechApi

  # @example Valid Usage
  #   Voice.new('Oksana') # ==> instance of voice class
  #
  # @example Bad Usage
  #   Voice.new(:bill)    # ==> VoiceNotAllowed exception

  class Voice

    ##
    # List of allowed voices
    #
    # @return [Array<String>]

    def self.list
      %i(jane oksana alyss omazh zahar ermil)
    end

    # @return [Symbol]
    #   possible values: :jane, :oksana, :alyss, :omazh, :zahar, :ermil

    attr_reader :name

    def initialize(voice)
      @name = voice.downcase.to_sym
      raise VoiceNotAllowed, voice unless voice_known? @name
    end

    private

    def voice_known?(name)
      Voice.list.include? name
    end

    ##
    # Raised when unknown voice was selected.

    class VoiceNotAllowed < YandexSpeechError
      def initialize(voice)
        super "Voice '#{voice}' not allowed for usage. To see list of allowed voices use Voice#list" end; end
  end # class Voice
end # module YandexSpeechApi
