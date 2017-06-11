# encoding: utf-8

# require_relative '../lib/yandex_speech'
require 'yandex_speech'

key = File.open('secret key/key').readline.strip

message = "Як поїдеш в об'їзд, то будеш і на обід, а як навпростець, то увечері."

speaker = YandexSpeechApi::Speaker.new
speaker.key      = key
speaker.voice    = 'Alyss'
speaker.language = 'Ukrain'
speaker.speed    = 0.6
speaker.emotion  = 'evil'

speaker.save_to_file message, '~/downloads/sound'
