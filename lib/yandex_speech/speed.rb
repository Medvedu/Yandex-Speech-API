# encoding: utf-8
# frozen_string_literal: true
module YandexSpeechApi
  class Speed

    # @example #1
    #   list[:slow]      # ==> 0.5
    #
    # @example #2
    #   list[:wrong_key] # ==> nil
    #
    # @return [Hash]

    def self.modes
      {
        :slowest  => 0.1,  # minimal allowed speed
        :slow     => 0.5,
        :standard => 1.0,  # default
        :fast     => 1.5,
        :fastest  => 3.0   # maximal allowed speed
      }
    end

    # @return [Float]
    #   In range [(0.1)..3.0]

    attr_reader :value

    def initialize(speed)
      @value = if speed.is_a? Numeric
                 speed.round 2
               else
                 Speed.modes[speed.downcase.to_sym]
               end

      raise SpeedModeNotAllowed, speed if @value.nil?
      raise SpeedValueNotInRange, @value unless speed_in_valid_range? @value
    end

    private

    def speed_in_valid_range?(number)
      number.between? 0.1, 3
    end

    ##
    # Raised when speed mode is unknown.

    class SpeedModeNotAllowed < YandexSpeechError
      def initialize(speed); super "Speed '#{speed}' not allowed for usage. To see list of allowed formats use Emotion#list." end; end

    ##
    # Raised when +speed+ param is not in [(0.1)..3] range.

    class SpeedValueNotInRange < YandexSpeechError
      def initialize(value); super "Speed value '#{value}' should be from [(0.1)..3] range" end; end
  end # class Speed
end # module YandexSpeechApi
