# encoding: utf-8

require_relative '../lib/yandex_speech'


speaker = YandexSpeechApi::Speaker.init

speaker.language = :russian


speaker.speed = :fast
puts speaker.speed.value
