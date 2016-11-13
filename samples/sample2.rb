# encoding: utf-8

require_relative '../lib/yandex_speech'

key = File.open('secret key/key').readline.strip

message = "Don't trouble trouble until trouble troubles you"

speaker = YandexSpeechApi::Speaker.init(key: key, language: 'english', voice: :zahar, speed: 0.23)
speaker.say message
