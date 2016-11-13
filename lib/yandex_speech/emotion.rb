# encoding: utf-8
# frozen_string_literal: true
module YandexSpeechApi
  class Emotion
    #
    # List of all allowed emotions:
    #
    def self.list
      %i(evil good neutral)
    end

    # ----------------------------------------------------

    #
    # normalized emotion type
    #
    attr_reader :type

    def initialize(emotion = :neutral)
      @type = emotion.downcase.to_sym
      raise EmotionNotAllowed, emotion unless emotion_known? @type
    end

    private

    def emotion_known?(emotion)
      self.class.list.include? emotion
    end

    #
    # This is supposed to been raised when unknown emotion has been selected.
    #
    class EmotionNotAllowed < StandardError
      def initialize(emotion); super "Emotion '#{emotion}' not allowed for usage. To see list of allowed emotions use Emotion#list" end; end
  end # class Emotion
end # module YandexSpeechApi