# encoding: utf-8
# frozen_string_literal: true
module YandexSpeechApi
  # dependencies from core lib
  require 'uri'
  require 'net/http'

  ##
  # loads *.rb files in requested order

  def self.req(**params)
    params[:files].each do |f|
      require File.join(__dir__, params[:folder].to_s, f)
    end
  end; private_class_method :req

  req files: %w(setters sounds connection speaker)
end # module YandexSpeechApi
