# encoding: utf-8
# frozen_string_literal: true
module YandexSpeechApi
  module Helpers

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

    def self.recognize_operation_system
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

    ##
    # Searches pathname for executable +cmd+.
    #
    # @return [Pathname, NilClass]
    #   Returns +Pathname+ if +cmd+ is present and executable.
    #   If search unsuccessful it returns +nil+.

    def self.find_executable(cmd)
      possible_extensions = ENV['PATHEXT'] ? ENV['PATHEXT'].split(';') : ['']

      ENV['PATH'].split(File::PATH_SEPARATOR).each do |path|
        possible_extensions.each do |extension|
          exe = Pathname.new(File.join(path, "#{cmd}#{extension}"))

          return exe if exe.executable? && exe.file?
        end
      end

      return nil # search unsuccessful
    end

  end # module Helpers
end # module YandexSpeechApi
