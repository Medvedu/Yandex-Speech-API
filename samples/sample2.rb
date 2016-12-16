# encoding: utf-8

# require_relative '../lib/yandex_speech'
require 'yandex_speech'

YandexSpeechApi::Key.global_key = File.open('secret key/key').readline.strip

message = "Don't trouble trouble until trouble troubles you"
speaker = YandexSpeechApi::Speaker.init(language: 'english', voice: :zahar, speed: 0.23)
speaker.say message
