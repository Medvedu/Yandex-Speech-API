# encoding: utf-8
# frozen_string_literal: true
module YandexSpeechApi
  module MP3_Player

    ##
    # Creates MP3 player instance. Depends from OS.
    #
    # @exception UnknownOsError
    #   raised when OS unknown.
    #
    # @return [Linux_MP3_Player, Mac_MP3_Player]

    def self.init
      @player ||=
        case Helpers::recognize_operation_system
        when :linux
          Linux_MP3_Player.new
        when :mac_os
          Mac_MP3_Player.new
        else
          raise UnknownOs
        end
    end

    ##
    # Raised when MP3_Player#init can not recognize what operation system is
    # used.

    class UnknownOs < YandexSpeechError
      def initialize; super "#{self.class}#recognize_operation_system cannot recognize your operation system!"; end; end
  end # module Player
end # module YandexSpeechApi
