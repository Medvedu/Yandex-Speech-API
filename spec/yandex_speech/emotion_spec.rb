# encoding: utf-8

require 'spec_helper'

module YandexSpeechApi
  describe Emotion do
    context '#new' do
      it 'raises an exception for unknown emotion' do
        expect { described_class.new :some_random_emotion }
          .to raise_exception described_class::EmotionNotAllowed
      end

      it 'creates object instance when emotion param is symbol' do
        expect(described_class.new(:good))
          .to be_instance_of Emotion
      end

      it 'creates object instance when emotion param is string' do
        expect(described_class.new('GOOD'))
          .to be_instance_of Emotion
      end

      it 'creates :good emotion without any exception' do
        expect { described_class.new :good }.to_not raise_exception
      end
    end # context #new

    context '#list' do
      it 'shows list of allowed emotions' do
        expect(described_class.list).to_not be_nil
      end
    end # context #list
  end # describe Emotion
end # module YandexSpeechApi
