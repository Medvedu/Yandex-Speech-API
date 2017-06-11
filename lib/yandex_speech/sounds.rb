# encoding: utf-8
# frozen_string_literal: true
module YandexSpeechApi
  module Sounds

    # @param [String] srs

    def self.play(srs)
      file = Tempfile.new 'yandex_speech_temp_file.mp3'
      file << srs
      file.close

      case operation_system
      when :linux
        exec "mpg123 -q '#{file.path}'"
      when :mac_os
        exec "afplay '#{file.path}'"
      end

      file.unlink
    end

    # @return [Symbol]

    def self.operation_system
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
    end; private_class_method :operation_system
  end # module Sounds
end # module YandexSpeechApi
