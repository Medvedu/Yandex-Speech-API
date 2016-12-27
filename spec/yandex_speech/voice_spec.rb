# encoding: utf-8

require 'spec_helper'

module YandexSpeechApi
  describe Voice do
    context '#new' do
      it 'raises an exception for unknown voice' do
        expect { described_class.new :some_random_voice }
          .to raise_exception described_class::VoiceNotAllowed
      end

      it 'creates object instance when voice param is a symbol' do
        expect(described_class.new(:alyss)).to be_instance_of Voice
      end

      it 'creates object instance when voice param is a string' do
        expect(described_class.new('ALYSs')).to be_instance_of Voice
      end
    end # context #new

    context '#list' do
      it 'shows list of allowed voices' do
        expect(described_class.list).to_not be_nil
      end
    end # context #list
  end # describe Voice
end # module YandexSpeechApi
