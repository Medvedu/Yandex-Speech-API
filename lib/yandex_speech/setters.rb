# encoding: utf-8
# frozen_string_literal: true
module YandexSpeechApi
  module Setters

    def voice=(new_voice)
      voice = new_voice.to_s.downcase
      unless allowed_voices.include? voice
        raise ArgumentError, "Unexpected voice: #{new_voice}"
      end
      @voice = voice
    end

    def speed=(new_speed)
      unless allowed_range.cover? new_speed
        raise ArgumentError, "Incorrect speech speed value: #{new_speed}"
      end
      @speed = new_speed.round(2)
    end

    def emotion=(new_emotion)
      emotion = new_emotion.to_s.downcase
      unless allowed_emotions.include? emotion
        raise ArgumentError, "Unexpected emotion: #{new_emotion}"
      end

      @emotion = emotion
    end

    def language=(new_language)
      @language = allowed_languages[new_language.to_s.downcase]

      unless language
        raise ArgumentError, "Unexpected language: #{new_language}"
      end
    end

    def format=(new_format)
      format = new_format.to_s.downcase
      unless allowed_formats.include? format
        raise ArgumentError, "Unknown parameter: #{new_format}"
      end

      @format = format
    end

    def key=(new_key)
      @key = new_key.to_s if new_key
    end

    private

    def allowed_emotions
      %w(evil good neutral)
    end

    def allowed_voices
      %w(jane oksana alyss omazh zahar ermil)
    end

    def allowed_languages
      {
        "english" => 'en-US',
        "russian" => 'ru‑RU',
        "turkey"  => 'tr-TR',
        "ukrain"  => 'uk-UK'
      }
    end

    def allowed_formats
      %w(mp3 wav opus)
    end

    def allowed_range
      0.1..3
    end
  end # module Validations
end # module YandexSpeechApi
