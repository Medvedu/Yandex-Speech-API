# encoding: utf-8

require_relative '../lib/yandex_speech'

key = File.open('secret key/key').readline.strip

speaker = YandexSpeechApi::Speaker.init key: key
speaker.save_to_file "в 2016 году в 11 месяц в 11 день в 16:55 произошел котоапокалипсис, а cтранная робо-женщина научились говорить.", "cats"
