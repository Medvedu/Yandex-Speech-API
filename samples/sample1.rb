# encoding: utf-8

# require_relative '../lib/yandex_speech'
require 'yandex_speech'

key = File.open('secret key/key').readline.strip

speaker = YandexSpeechApi::Speaker.new key: key, language: 'russian'
speaker.save_to_file 'Не будите спящего кота.'
