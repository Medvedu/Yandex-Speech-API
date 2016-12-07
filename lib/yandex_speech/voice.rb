# encoding: utf-8
# frozen_string_literal: true
module YandexSpeechApi
  #
  # @sample Valid Usage
  #   Voice.new('Oksana') # ==> instance of voice class
  #
  # @sample Bad Usage
  #   Voice.new(:bill)    # ==> VoiceNotAllowed exception
  #
  class Voice
    ##
    # List of allowed voices
    #
    # @return [Array<String>]
    #
    def self.list
      %i(jane oksana alyss omazh zahar ermil)
    end

    # ----------------------------------------------------

    #
    # @return [Symbol]
    #    possible values: :jane, :oksana, :alyss, :omazh, :zahar, :ermil
    #
    attr_reader :name

    def initialize(voice = :jane)
      @name = voice.downcase.to_sym
      raise VoiceNotAllowed, voice unless voice_known? @name
    end

    private

    def voice_known?(name)
      Voice.list.include? name
    end

    ##
    # This is supposed to been raised when unknown voice was selected.
    #
    class VoiceNotAllowed < StandardError
      def initialize(voice)
        super "Voice '#{voice}' not allowed for usage. To see list of allowed voices use Voice#list"
      end; end
  end # class Voice
end # module YandexSpeechApi
