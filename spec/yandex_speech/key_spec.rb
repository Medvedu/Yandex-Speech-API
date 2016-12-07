# encoding: utf-8

require 'spec_helper'

module YandexSpeechApi
  describe Key do
    after :each do
      described_class.instance_variable_set :@global_key, nil
    end

    context '#global_key=(other)' do
      it 'raises an exception +other+ param is not present #1' do
        key = described_class.new
        expect { described_class.global_key = key }
          .to raise_error Key::InvalidGlobalKey
      end

      it 'raises an exception +other+ param is not present #2' do
        key = described_class.new :unknown
        expect { described_class.global_key = key }
          .to raise_error Key::InvalidGlobalKey
      end
    end # context '#global_key=(other)'

    context '#global_key' do
      it 'returns +false+ when global key not set' do
        expect(Key.global_key?).to be_falsey
      end

      it 'returns +true+ when global key set' do
        described_class.global_key = 'Secret Key'
        expect(Key.global_key?).to be_truthy
      end
    end # context '#global_key'

    context '#get' do
      it 'raises an exception for not defined (instance or global) key' do
        key = described_class.new
        expect { key.get }.to raise_error Key::KeyNotDefined
      end

      it 'not raises an exception when instance key defined' do
        key = described_class.new 'xxxxx-xxxxx-xxxxx-xxxxx-xxxxx'
        expect { key.get }.to_not raise_error
      end

      it 'not raises an exception when global key defined' do
        described_class.global_key = 'xxxxx-xxxxx-xxxxx-xxxxx-xxxxx'
        key = described_class.new
        expect { key.get }.to_not raise_error
      end

      it 'not raises an exception for any key instance when global key defined' do
        described_class.global_key = 'xxxxx-xxxxx-xxxxx-xxxxx-xxxxx'

        key = described_class.new
        expect { key.get }.to_not raise_error

        key2 = described_class.new 'test key'
        expect { key2.get }.to_not raise_error

        key3 = described_class.new
        expect { key3.get }.to_not raise_error
      end
    end # context #get
  end # describe Key
end # module YandexSpeechApi
