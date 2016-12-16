# encoding: utf-8

# require_relative '../lib/yandex_speech'
require 'yandex_speech'

key = File.open('secret key/key').readline.strip
message = 'one two three. one two three. one two three four.'

speaker = YandexSpeechApi::Speaker.init do |s|
  s.key      = key
  s.voice    = :jane
  s.language = :english
  s.speed    = :slow
  s.emotion  = :good
end

speaker.say message
