# encoding: utf-8

require 'spec_helper'

module YandexSpeechApi
  describe Connection do
    context '#send' do
      it 'raises an exception for fallen request' do
        stub_request(:any, /https:\/\/tts.voicetech.yandex.net\/.*/)
          .to_return status: 500, body: 'Body'

        expect {described_class.send {}}
          .to raise_exception described_class::ConnectionError
      end

      it 'returns response body for successful request' do
        stub_request(:any, /https:\/\/tts.voicetech.yandex.net\/.*/)
          .to_return status: 200, body: 'Body'

        expect(described_class.send {}).to be_eql "Body"
      end
    end # context '#send'
  end # describe Connection
end # module YandexSpeechApi
