# encoding: utf-8

require_relative '../lib/yandex_speech'


speaker = YandexSpeechApi::Speaker.init

speaker.language = :turkey

# speaker.voice =
# speaker.sound_quality
