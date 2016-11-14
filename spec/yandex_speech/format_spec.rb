# encoding: utf-8

require 'spec_helper'

describe YandexSpeechApi::Format do
  context '#new' do
    it 'creates instance with :mp3 type by default' do
      format_instance = described_class.new
      expect(format_instance.type).to be :mp3
    end

    it 'raises an exception for unknown format type' do
      expect { described_class.new :some_random_format }
        .to raise_exception described_class::FormatNotAllowed
    end

    it "creates object instance when format param is symbol" do
      expect(described_class.new :wav)
        .to be_instance_of YandexSpeechApi::Format
    end

    it "creates object instance when format param is string" do
      expect(described_class.new 'Wav')
        .to be_instance_of YandexSpeechApi::Format
    end
  end # context #new

  context '#list' do
    it 'shows list of all possible formats' do
      expect(described_class.list).to_not be_nil
    end
  end # context #list
end # describe YandexSpeechApi::Format
