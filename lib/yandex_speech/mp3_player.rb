# encoding: utf-8
# frozen_string_literal: true
module YandexSpeechApi
  #
  # Highly simple MP3_Player that should working in most popular
  # operation systems: windows, mac os, linux.
  #
  # MP3_Player is an abstract class. Use MP3_Player#init to create
  # os-specific player version.
  #
  # WARNING! Do not forget to overload +validate_requirements+
  #                                    +validate_mp3_format+
  # in child classes.
  #
  class MP3_Player
    class << self
      #
      # constructor method MP3_Player#init.
      #
      # This method used to determinate operation system and call OS-specific
      # constructor.
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
      # Proxy method. Used to call private constructor for child
      # class instance.
      #
      # Do not call MP3_Player#build method it will raise an exception!
      #
      def build
        if self.to_s.split('::').last == 'MP3_Player'
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
    # method #play. +template method pattern+
    #
    # Used to validate&play mp3 file with specific +filename+
    #
    def play(filename)
      validate_mp3_format filename
      validate_requirements
      play_mp3 filename
    end

    private

    #
    # +abstract+ method. Os specific file launcher.
    #
    def play_mp3(filename)
      if self.class.name.split('::').last == 'MP3_Player'
        raise StandardError, "Abstract method called"
      else
        raise MethodNotImplementedError.new self, __method__.to_s
      end
    end

    #
    # +abstract+ method. Os specific requirements validator.
    #
    def validate_requirements
      if self.class.name.split('::').last == 'MP3_Player'
        raise StandardError, "Abstract method called"
      else
        raise MethodNotImplementedError.new self, __method__.to_s
      end
    end

    #
    # raise an exception if +filename+ without '.mp3' extension
    #
    def validate_mp3_format(filename)
      unless File.extname(filename).downcase == '.mp3'
        raise WrongFileExtension .new filename
      end
    end

    #
    # This is supposed to been raised when +filename+ has wrong (not mp3) extension.
    #
    # Used to give minimal protection against files with corrupted format.
    #
    class WrongFileExtension < StandardError
      def initialize(filename); super "mp3 player can work only with files with '.mp3' extension. Please change extension for #{filename} if you sure that format is correct!'" end; end

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
      def initialize(klass, method_name); super "class '#{klass}' called not implemented method: '##{method_name}'." end; end
  end # class MP3_Player

  #
  # ----------------------------------------------------
  #

  class MP3_Player::Linux_MP3_Player < MP3_Player
    private
    #
    # check if program +mpg123+ is installed.
    #
    def validate_requirements
      output = `type 'mpg123'`
      raise LinuxNotInstalled.new 'mpq123' if output.length.zero?
    end

    #
    # call filename throw +mpq123+
    #
    def play_mp3(filename)
      `mpg123 #{filename}`
    end

    #
    # This is supposed to been raised when necessary linux program not found.
    #
    class LinuxNotInstalled < StandardError
      def initialize(name); super "Program '#{name}' not found!" end; end
  end

  # ----------------------------------------------------

  # todo: add windows support (see MP3_Player::Linux_MP3_Player for an example)
  class MP3_Player::Windows_MP3_Player < MP3_Player
  end

  # ----------------------------------------------------

  # todo: add mac support (see MP3_Player::Linux_MP3_Player for an example)
  class MP3_Player::Mac_MP3_Player < MP3_Player
  end
end # module YandexSpeechApi
