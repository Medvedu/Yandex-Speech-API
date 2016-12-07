# encoding: utf-8

require 'spec_helper'

module YandexSpeechApi
  describe Key do
    context '#get' do
      it 'raises an exception for not defined (instance or global) key' do
        key = described_class.new
        expect{key.get}.to raise_error(Key::KeyNotDefined)
      end

      it 'not raises an exception if instance key defined' do
        key = described_class.new "xxxxx-xxxxx-xxxxx-xxxxx-xxxxx"
        expect{key.get}.to_not raise_error
      end

      it 'not raises an exception if global key defined' do
        described_class.global_key = "xxxxx-xxxxx-xxxxx-xxxxx-xxxxx"
        key = described_class.new
        expect{key.get}.to_not raise_error
      end
    end # context #get
  end # describe Key
end # module YandexSpeechApi
