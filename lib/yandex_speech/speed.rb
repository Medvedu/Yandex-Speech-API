# encoding: utf-8
# frozen_string_literal: true
module YandexSpeechApi
  class Speed
    class << self
      ##
      # List of speed modes
      #
      # @return [Array<String>]
      #
      def list
        list_mapping.keys
      end

      ##
      # Returns associated with key speed value.
      #
      # @sample Sample 1
      #   list_mapping[:slow]      # ==> 0.5
      #
      # @sample Sample 2
      #   list_mapping[:wrong_key] # ==> nil
      #
      # @return [HASH]
      #
      def list_mapping
        {
          :slowest  => 0.1,  # minimal allowed speed
          :slow     => 0.5,
          :standard => 1.0,  # default
          :fast     => 1.5,
          :fastest  => 3.0   # maximal allowed speed
        }
      end
    end # class << self

    private_class_method :list_mapping

    # ----------------------------------------------------

    #
    # @return [Float]
    #   In range [(0.1)..3.0]
    #
    attr_reader :value

    def initialize(speed = :standard)
      @value = if speed.is_a? Numeric
                 speed.round 2
               else
                 list_mapping[speed.downcase.to_sym]
               end

      raise SpeedModeNotAllowed, speed if @value.nil?
      raise SpeedValueNotInRange, @value unless speed_in_valid_range? @value
    end

    private

    def speed_in_valid_range?(number)
      number.between? 0.1, 3
    end

    def list_mapping
      self.class.send :list_mapping
    end

    ##
    # This is supposed to been raised when speed mode is unknown.
    #
    class SpeedModeNotAllowed < StandardError
      def initialize(speed); super "Speed '#{speed}' not allowed for usage. To see list of allowed formats use Emotion#list." end; end

    ##
    # This is supposed to been raised when +speed+ param is not in [(0.1)..3] range.
    #
    class SpeedValueNotInRange < StandardError
      def initialize(value); super "Speed value '#{value}' should be from [(0.1)..3] range" end; end
  end # class Speed
end # module YandexSpeechApi
