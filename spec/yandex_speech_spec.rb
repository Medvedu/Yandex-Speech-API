# encoding: utf-8

require 'spec_helper'

module YandexSpeechApi
  describe YandexSpeechApi do
    context "Going to be tested with successful Net:HTTP requests" do
      STUBBED_PATH = File.join __dir__, 'stubbed'
      TEMP_PATH    = File.join __dir__, 'tmp'

      before :each do # stub Net:HTTP request
        path = File.join(STUBBED_PATH, "stubbed_cat.mp3")
        stub_request(:get, /https:\/\/tts.voicetech.yandex.net\/.*/)
          .to_return status: 200, body: File.open(path).read
      end

      after :each do # clean-up tmp folder
        Pathname.new(TEMP_PATH).children.reject { |c| c.basename.to_s == '.gitkeep' }
                                        .each(&:unlink)
      end

      context "Speaker#save_to_file" do
        it 'saves audio-file' do
          speaker = Speaker.init key: "xxxxx-xxxxx-xxxxx-xxxxx"

          path = speaker.save_to_file("Не будите спящего кота.",
                                      "spec/tmp/not_today")

          expect(File.exist?(path)).to be_truthy
        end

        it 'works fine when global key is set' do
          Key.global_key = "xxxxx-xxxxx-xxxxx-xxxxx"

          bobby = Speaker.init
          path_to_bob_file =
            bobby.save_to_file "Не будите спящего кота.", "spec/tmp/bobby"

          expect(File.exist?(path_to_bob_file)).to be_truthy
        end

        it 'works fine when filename not set' do
          expect_any_instance_of(Speaker).to receive(:generate_path)
            .and_return(File.join(TEMP_PATH, "bobby.mp3"))

          bobby = Speaker.init(key: "xxxx")
          path_to_bob_file = bobby.save_to_file "Не будите спящего кота."

          expect(File.exist?(path_to_bob_file)).to be_truthy
        end

        it 'sets correct params for object when block syntax is used' do
          jane = Speaker.init do |j|
            j.voice    = :jane
            j.language = :english
            j.speed    = :slow
            j.emotion  = :good
            j.format   = :opus
          end

          expect(jane.voice.name).to    be_eql :jane
          expect(jane.language.code).to be_eql 'en-US'
          expect(jane.speed.value).to   be_eql 0.5
          expect(jane.emotion.type).to  be_eql :good
          expect(jane.format.type).to   be_eql :opus
        end

        it 'sets correct params for object when hash syntax is used' do
          jane = Speaker.init(voice: :jane, language: :english,
                              speed: :slow, emotion: :good)

          expect(jane.voice.name).to    be_eql :jane
          expect(jane.language.code).to be_eql 'en-US'
          expect(jane.speed.value).to   be_eql 0.5
          expect(jane.emotion.type).to  be_eql :good
        end
      end # context "Speaker#save_to_file"

      # ----------------------------------------------------

      context "Speaker#say" do
        it 'calls mp3 player' do
          expect_any_instance_of(MP3_Player::Base).to receive(:play)

          speaker = Speaker.init key: "xxxxx-xxxxx-xxxxx-xxxxx"
          speaker.say("Не будите спящего кота.")
        end

        it 'raises an exception when text too long' do
          speaker = Speaker.init key: "xxxxx-xxxxx-xxxxx-xxxxx"
          phrase = 'some phrase' * 5000

          expect{ speaker.say phrase }.to raise_exception Speaker::TextTooBig
        end
      end # context "Speaker#save_to_file"
    end # context "Going to be tested with successful Net:HTTP requests"

    # ----------------------------------------------------

    context 'Going to be tested with failed Net:HTTP requests' do
      it 'raises exception when connection falls' do
        stub_request(:get, /https:\/\/tts.voicetech.yandex.net\/.*/)
          .to_return status: 400, body: "Unreachable body"

          bobby = Speaker.init key: "xxxxx-xxxxx-xxxxx-xxxxx"

          expect{bobby.say "313"}
            .to raise_exception Connection::ConnectionError
        end
    end # context "Going to be tested with failed Net:HTTP requests"
  end # describe YandexSpeechApi
end # module YandexSpeechApi
