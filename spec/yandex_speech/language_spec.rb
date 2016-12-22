# encoding: utf-8

require 'spec_helper'

module YandexSpeechApi
  describe Language do
    context '#new' do
      it 'raises an exception for unknown language' do
        expect { described_class.new :wommi_lang }
          .to raise_exception described_class::UnknownLanguageError
      end

      it 'creates object instance when +language+ param is symbol' do
        expect{described_class.new(:ukrain)}.to_not raise_exception
      end

      it 'creates object instance when +language+ param is string' do
        expect{described_class.new('Ukrain')}.to_not raise_exception
      end
    end # context #new

    context '#allowed_languages' do
      it 'shows list of all possible languages' do
        expect(described_class.allowed_languages).to_not be_nil
      end
    end # context #allowed_languages

    context '#code' do
      it 'returns valid code for any class instance from #list' do
        sample  = described_class.allowed_languages.sample

        expect{described_class.new(sample)}.to_not raise_exception
      end
    end # context #code
  end # describe Language
end # module YandexSpeechApi
