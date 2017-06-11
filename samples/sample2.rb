# encoding: utf-8

# require_relative '../lib/yandex_speech'
require 'yandex_speech'

YandexSpeechApi.key = File.open('secret key/key').readline.strip

message = "Don't trouble trouble until trouble troubles you"
speaker = YandexSpeechApi::Speaker.new voice: :zahar, speed: 1.1
speaker.say message
