# encoding: utf-8
# frozen_string_literal: true
module YandexSpeechApi
  #
  # dependents from core lib
  #

  #
  # dependents from rubygems.org
  #

  require 'rest-client'
  require 'addressable'

  class << self
    private

    def self.load(**params)
      params[:files].each do |f|
        require File.join(__dir__, params[:folder].to_s, f)
      end
    end

    # project structure

    load files: %w(key language format voice emotion speed connection speaker)
  end # class << self
end # module YandexSpeechApi
