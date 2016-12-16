# encoding: utf-8
# frozen_string_literal: true
module YandexSpeechApi

  ##
  # Very, very simple MP3_Player that designed to work on Mac Os, Linux.
  #
  # @example #1
  #   player = MP3_Player.init
  #   player.play filename

  class MP3_Player
    class << self
      ##
      # Creates MP3 player instance. Depends from OS.
      #
      # @exception UnknownOsError
      #   raised when OS unknown.
      #
      # @return [Linux_MP3_Player, Mac_MP3_Player]

      def init
        @player ||=
          case recognize_operation_system
          when :linux
            Linux_MP3_Player.build
          when :mac_os
            Mac_MP3_Player.build
          else
            raise UnknownOsError
          end
      end

      ##
      # Player constructor.
      #
      # @exception AbstractClassCreationError
      #   raised when MP3_Player#build called
      #
      # @return [Linux_MP3_Player, Mac_MP3_Player]
      #
      def build
        if to_s.split('::').last == 'MP3_Player'
          raise AbstractClassCreationError
        else
          new
        end
      end

      private

      ##
      # No need to create new MP3_Player object for each MP3_Player#init call.
      #
      # @return [Linux_MP3_Player, Mac_MP3_Player]

      attr_reader :player

      ##
      # From what OS we launched?
      #
      # @example #1
      #   recognize_operation_system # ==> :linux
      #
      # @example #2
      #   recognize_operation_system # ==> :unknown
      #
      # @return [Symbol]
      #   OS name

      def recognize_operation_system
        case RbConfig::CONFIG['host_os']
        when /mswin|msys|mingw|cygwin|bccwin|wince|emc/
          :windows
        when /darwin|mac os/
          :mac_os
        when /linux/
          :linux
        else
          :unknown
        end
      end
    end # class << self

    private_class_method :new
    private_class_method :recognize_operation_system

    ##
    # Plays the sound

    def play(filename)
      validate_mp3_format filename
      validate_requirements
      play_mp3 filename
    end

    private

    #
    # @exception StandardError
    #   raised if #play_mp3 was called from MP3_Player
    #
    # @exception MethodNotImplementedError
    #   raised if #play_mp3 was called, but not overridden from MP3_Player child

    def play_mp3(_filename)
      if self.class.name.split('::').last == 'MP3_Player'
        raise StandardError, 'Abstract method called'
      else
        raise MethodNotImplementedError.new self, __method__.to_s
      end
    end

    ##
    # Validates OS requirements. Abstract
    #
    # @exception StandardError
    #   raised if #validate_requirements was called from MP3_Player
    #
    # @exception MethodNotImplementedError
    #   raised if #validate_requirements was called, but not overridden from MP3_Player child

    def validate_requirements
      if self.class.name.split('::').last == 'MP3_Player'
        raise StandardError, 'Abstract method called'
      else
        raise MethodNotImplementedError.new self, __method__.to_s
      end
    end

    ##
    # Raises an exception if +filename+ without '.mp3' extension

    def validate_mp3_format(filename)
      unless File.extname(filename).casecmp('.mp3').zero?
        raise WrongFileExtension, filename
      end
    end

    ##
    # Raised when +filename+ has wrong (not mp3) extension. Used to give
    # minimal protection against files with unknown format.

    class WrongFileExtension < StandardError
      def initialize(filename); super "Mp3 player can work only with files with '.mp3' extension. Please change extension for #{filename} if you sure that format is correct!'" end; end

    ##
    # Raised when MP3_Player#init can not recognize what operation system is
    # used.

    class UnknownOsError < StandardError
      def initialize; super "#{self.class}#recognize_operation_system cannot recognize your operation system!"; end; end

    ##
    # Raised when someone tries to call constructor for abstract
    # +MP3_Player+ class.

    class AbstractClassCreationError < StandardError
      def initialize; super "You are not allowed to call constructor for 'MP3_Player' class!" end; end

    ##
    # Raised when child class tries to call not implemented method.

    class MethodNotImplementedError < StandardError
      def initialize(klass, method_name); super "Class '#{klass}' called not implemented method: '##{method_name}'." end; end
  end # class MP3_Player

  #
  # ----------------------------------------------------
  #

  class MP3_Player::Linux_MP3_Player < MP3_Player
    private

    ##
    # raises an exception unless +mpg123+ installed.

    def validate_requirements
      output = `type 'mpg123'`
      raise LinuxNotInstalled, 'mpq123' if output.length.zero?
    end

    ##
    # plays selected +filename+ throw +mpq123+

    def play_mp3(filename)
      `mpg123 -q '#{filename}'`
    end

    ##
    # Raised when necessary linux program not found.

    class LinuxNotInstalled < StandardError
      def initialize(name); super "Program '#{name}' not found!" end; end
  end # class MP3_Player::Linux_MP3_Player

  # ----------------------------------------------------

  class MP3_Player::Mac_MP3_Player < MP3_Player
    def validate_requirements
      nil
    end

    def play_mp3(filename)
      `afplay '#{filename}'`
    end
  end # MP3_Player::Mac_MP3_Player
end # module YandexSpeechApi
