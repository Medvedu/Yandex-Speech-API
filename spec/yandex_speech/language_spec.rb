# encoding: utf-8

require 'spec_helper'

module YandexSpeechApi
  describe Language do
    context '#init' do
      it 'creates Language::English instance by default' do
        language_instance = described_class.init
        expect(language_instance).to be_instance_of described_class::English
      end

      it 'raises an exception for unknown language' do
        expect { described_class.init :wommi_lang }
          .to raise_exception described_class::UnknownLanguageError
      end

      it 'creates object instance when emotion param is symbol' do
        expect(described_class.init(:ukrain))
          .to be_instance_of described_class::Ukrain
      end

      it 'creates object instance when emotion param is string' do
        expect(described_class.init('Ukrain'))
          .to be_instance_of described_class::Ukrain
      end
    end # context #init

    context '#new' do
      it 'raises an exception when private constructor has been called' do
        expect { described_class.new :russian }.to raise_exception NoMethodError
      end
    end # context #new

    context '#list' do
      it 'shows list of all possible languages' do
        expect(described_class.list).to_not be_nil
      end

      it 'each element from #list is valid +Language+ instance' do
        described_class.list.each do |klass_name|
          element = described_class.const_get(klass_name)
          expect(element.build).to respond_to :code
        end
      end
    end # context #list

    context '#code' do
      it 'raises an exception when method called for +Language+ class' do
        expect { described_class.build.code }
          .to raise_exception described_class::AbstractClassCreationError
      end

      it 'returns valid code for any class instance from #list' do
        sample  = described_class.list.sample
        element = described_class.const_get sample
        expect(element.build.code).to_not be_nil
      end
    end # context #code
  end # describe Language
end # module YandexSpeechApi
