# encoding: utf-8
# frozen_string_literal: true
module YandexSpeechApi
  #
  # Very, very simple MP3_Player that designed to work in most popular
  # operation systems, like: Windows, Mac Os, Linux.
  #
  # MP3_Player is an abstract class. Use MP3_Player#init to create
  # os-specific instance.
  #
  # WARNING! Do not forget to overload +validate_requirements+
  #                                    +validate_mp3_format+
  # methods in any child class.
  #
  class MP3_Player
    class << self
      #
      # MP3_Player#init
      #
      # This method used to determinate operation system and redirect
      # call to OS-specific class constructor.
      #
      # Usage example:
      #
      #  …
      #  player = MP3_Player.init
      #  player.play filename
      #  …
      #
      def init
        case recognize_operation_system
        when :windows
          Windows_MP3_Player.build
        when :linux
          Linux_MP3_Player.build
        when :mac_os
          Mac_MP3_Player.build
        else
          raise UnknownOsError
        end
      end

      #
      # Proxy method. Used to call private #new constructor in valid +self+
      #
      # Do not use MP3_Player#build method. It will raise an exception!
      #
      def build
        if to_s.split('::').last == 'MP3_Player'
          raise AbstractClassCreationError
        else
          new
        end
      end

      private

      #
      # output: current operation system [symbol]
      #
      # example: recognize_operation_system # ==> :linux
      #          recognize_operation_system # ==> :unknown
      #
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

    # ----------------------------------------------------

    #
    # #play. USER ENDPOINT
    #
    # Used to validate and play mp3 audio file: +filename+
    #
    def play(filename)
      validate_mp3_format filename
      validate_requirements
      play_mp3 filename
    end

    private

    #
    # +abstract+ method. Os specific player launcher.
    #
    def play_mp3(_filename)
      if self.class.name.split('::').last == 'MP3_Player'
        raise StandardError, 'Abstract method called'
      else
        raise MethodNotImplementedError.new self, __method__.to_s
      end
    end

    #
    # +abstract+ method. Os specific requirements validator.
    #
    def validate_requirements
      if self.class.name.split('::').last == 'MP3_Player'
        raise StandardError, 'Abstract method called'
      else
        raise MethodNotImplementedError.new self, __method__.to_s
      end
    end

    #
    # raise an exception if +filename+ without '.mp3' extension
    #
    def validate_mp3_format(filename)
      unless File.extname(filename).casecmp('.mp3').zero?
        raise WrongFileExtension, filename
      end
    end

    #
    # This is supposed to been raised when +filename+ has wrong (not mp3) extension.
    #
    # Used to give minimal protection against files with corrupted format.
    #
    class WrongFileExtension < StandardError
      def initialize(filename); super "Mp3 player can work only with files with '.mp3' extension. Please change extension for #{filename} if you sure that format is correct!'" end; end

    #
    # This is supposed to been raised when MP3_Player#init can not
    # recognize what operation system is used.
    #
    class UnknownOsError < StandardError
      def initialize; super "#{self.class}#recognize_operation_system cannot recognize your operation system!" end; end

    #
    # This is supposed to been raised when someone tries to call constructor
    # for abstract +MP3_Player+ class.
    #
    class AbstractClassCreationError < StandardError
      def initialize; super "You are not allowed to call constructor for 'MP3_Player' class!" end; end

    #
    # This is supposed to been raised when child class tries to call
    # not implemented method.
    #
    class MethodNotImplementedError < StandardError
      def initialize(klass, method_name); super "Class '#{klass}' called not implemented method: '##{method_name}'." end; end
  end # class MP3_Player

  #
  # ----------------------------------------------------
  #

  class MP3_Player::Linux_MP3_Player < MP3_Player
    private

    #
    # raises an exception unless +mpg123+ installed.
    #
    def validate_requirements
      output = `type 'mpg123'`
      raise LinuxNotInstalled, 'mpq123' if output.length.zero?
    end

    #
    # play selected +filename+ throw +mpq123+
    #
    def play_mp3(filename)
      `mpg123 '#{filename}'`
    end

    #
    # This is supposed to been raised when necessary linux program not found.
    #
    class LinuxNotInstalled < StandardError
      def initialize(name); super "Program '#{name}' not found!" end; end
  end

  # ----------------------------------------------------

  # TODO: add windows support (see MP3_Player::Linux_MP3_Player for an example)
  class MP3_Player::Windows_MP3_Player < MP3_Player
  end

  # ----------------------------------------------------

  class MP3_Player::Mac_MP3_Player < MP3_Player
    def validate_requirements
      nil
    end

    def play_mp3(filename)
      `afplay '#{filename}'`
    end
  end
end # module YandexSpeechApi
