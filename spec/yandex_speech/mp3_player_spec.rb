# encoding: utf-8

require 'spec_helper'

module YandexSpeechApi
  describe MP3_Player do
    context '#init' do
      it 'raises an exception if mp3_player cannot been created' do
        allow(Helpers).to receive(:recognize_operation_system)
          .and_return 'unknown'

        expect{MP3_Player.init}.to raise_exception MP3_Player::UnknownOs
      end

      it 'creates an mp3_player instance' do
        allow(Helpers).to receive(:recognize_operation_system)
          .and_return :linux

        expect(MP3_Player.init).to be_instance_of MP3_Player::Linux_MP3_Player
      end
    end
  end # describe MP3_Player
end # module YandexSpeechApi
