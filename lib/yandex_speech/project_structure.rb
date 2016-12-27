# encoding: utf-8
# frozen_string_literal: true
module YandexSpeechApi
  # dependencies from core lib
  require 'rbconfig'
  require 'uri'
  require 'net/http'

  ##
  # Core class for all exceptions that can be raised in YandexSpeechApi lib..

  class YandexSpeechError < StandardError; end

  # project structure

  ##
  # loads *.rb files in requested order

  def self.load(**params)
    params[:files].each do |f|
      require File.join(__dir__, params[:folder].to_s, f)
    end
  end
  private_class_method :load

  load folder: 'mp3_player',
       files:  %w(base mac_mp3_player linux_mp3_player)

  load files: %w(helpers mp3_player key language format voice emotion speed connection speaker)
end # module YandexSpeechApi
