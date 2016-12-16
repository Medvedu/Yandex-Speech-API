# encoding: utf-8
# frozen_string_literal: true
module YandexSpeechApi
  class Emotion

    ##
    # List of allowed emotions
    #
    # @return [Array<String>]

    def self.list
      %i(evil good neutral)
    end

    #
    # @return [Symbol]
    #   possible values: :evil, :good or :neutral

    attr_reader :type

    def initialize(emotion = :neutral)
      @type = emotion.downcase.to_sym
      raise EmotionNotAllowed, emotion unless emotion_known? @type
    end

    private

    def emotion_known?(emotion)
      Emotion.list.include? emotion
    end

    ##
    # Raised when unknown emotion has been selected.

    class EmotionNotAllowed < StandardError
      def initialize(emotion); super "Emotion '#{emotion}' not allowed for usage. To see list of allowed emotions use Emotion#list" end; end
  end # class Emotion
end # module YandexSpeechApi
