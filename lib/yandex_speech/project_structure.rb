# encoding: utf-8
# frozen_string_literal: true
module YandexSpeechApi

  # dependencies from core lib
  require 'rbconfig'

  # dependencies from rubygems.org
  require 'rest-client'
  require 'addressable'

  # project structure

  ##
  # loads *.rb files in requested order

  def self.load(**params)
    params[:files].each do |f|
      require File.join(__dir__, params[:folder].to_s, f)
    end
  end
  private_class_method :load

  load files: %w(mp3_player key language format voice emotion speed connection speaker)
end # module YandexSpeechApi
