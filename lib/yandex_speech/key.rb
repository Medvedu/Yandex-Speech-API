# encoding: utf-8
# frozen_string_literal: true
module YandexSpeechApi
  class Key
    attr_reader :value

    def self.warn_message
      %W( WARNING! You initialized Speaker class without key! It means you can
      not use YandexSpeechApi service. You can get your key from there:
      'https://tech.yandex.ru/speechkit').join ' '
    end

    def initialize(key)
      @value = key
  #    warn self.class.warn_message if key == :unknown
    end
  end # class Key
end # module YandexSpeechApi
