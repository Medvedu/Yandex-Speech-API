# encoding: utf-8

require_relative '../lib/yandex_speech'

key = File.open('secret key/key').readline.strip

message = "Як поїдеш в об'їзд, то будеш і на обід, а як навпростець, то увечері."

speaker = YandexSpeechApi::Speaker.init
speaker.key      = key
speaker.voice    = 'Alyss'
speaker.language = 'Ukrain'
speaker.speed    = 1.2
speaker.emotion  = 'good'
speaker.save_to_file message, '~/downloads/sound'
