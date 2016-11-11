# encoding: utf-8
# frozen_string_literal: true
module YandexSpeechApi
  class Speed
    #
    # List of all allowed speed modes:
    #
    def self.list
      list_mapping.keys
    end

    #
    # output: [HASH] with pairs: [:mode => associated speed value]
    #
    # samples: list_mapping[:slow]      # ==> 0.1
    #          list_mapping[:wrong_key] # ==> nil
    #
    def self.list_mapping
      {
        :slow     => 0.1, # minimal allowed value
        :standard => 1,   # recommended
        :fast     => 3    # maximal allowed value
      }
    end

    # ----------------------------------------------------

    #
    # normalized speed value
    #
    attr_reader :value

    def initialize(speed)
      @value = if speed.is_a? Numeric
                 speed.round 2
               else
                 self.class.list_mapping[speed.downcase.to_sym]
               end

      raise SpeedModeNotAllowed.new speed if @value.nil?
      raise SpeedValueNotInRange.new @value unless speed_in_valid_range? @value
    end

    private

    def speed_in_valid_range?(number)
      number.between? 1,3
    end

    #
    # This is supposed to been raised when speed mode is unknown.
    #
    class SpeedModeNotAllowed < StandardError
      def initialize(speed); super "speed '#{speed}' not allowed for usage. To see list of allowed formats use Emotion#list." end; end

    #
    # This is supposed to been raised when speed is not in [1..3] range.
    #
    class SpeedValueNotInRange < StandardError
      def initialize(value); super "speed value '#{value}' should be from [1..3] range" end; end
  end # class Speed
end # module YandexSpeechApi
