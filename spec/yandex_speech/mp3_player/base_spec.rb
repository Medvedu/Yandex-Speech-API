# encoding: utf-8

require 'spec_helper'

module YandexSpeechApi
module MP3_Player
  describe Base do # no-doc
    context '#play' do
      it 'raises an exception when file not found' do
        expect{described_class.new.play('lalalala.')}
          .to raise_exception described_class::FileNotFound
      end

      it 'raises an exception when file has wrong extension' do
        expect_any_instance_of(described_class)
          .to receive(:validate_file_presence).and_return nil

        expect{described_class.new.play('lalalala.')}
          .to raise_exception described_class::UnknownExtension
      end
    end # context '#play'
  end # describe Linux_MP3_Player
end # module MP3_Player
end # module YandexSpeechApi
