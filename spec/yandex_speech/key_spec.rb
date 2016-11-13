# encoding: utf-8

require 'spec_helper'

describe YandexSpeechApi::Key do
  context '#value' do
    it 'returns :unknown key by default' do
      instance = described_class.new
      expect(instance.value).to be_eql :unknown
    end
  end # context #new

  context '#present?' do
    it 'returns false for default key' do
      instance = described_class.new
      expect(instance.present?).to be_falsey
    end

    it 'returns true for custom key' do
      instance = described_class.new "xxxxx-xxxxx-xxxxx-xxxxx-xxxxx"
      expect(instance.present?).to be_truthy
    end
  end # context #present?
end # describe YandexSpeechApi::Key
