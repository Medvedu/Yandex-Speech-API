# encoding: utf-8

require_relative '../lib/yandex_speech'

key = File.open('secret key/key').readline.strip

speaker = YandexSpeechApi::Speaker.init key: key
speaker.save_to_file "Не будите спящего кота."
