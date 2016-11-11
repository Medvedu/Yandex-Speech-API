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

  #
  # project structure
  #

  require_relative 'key'
  require_relative 'language'
  require_relative 'format'
  require_relative 'voice'
  require_relative 'emotion'
  require_relative 'speed'
  require_relative 'connection'

  require_relative 'speaker'
end # module YandexSpeechApi
