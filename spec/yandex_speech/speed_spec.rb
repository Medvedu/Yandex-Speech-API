# encoding: utf-8

require 'spec_helper'

describe YandexSpeechApi::Speed do
  context '#new' do
  end # context #new

  context '#list' do
    it 'shows list of allowed speed modes' do
      expect(described_class.list).to_not be_nil
    end
  end # context #list
end # describe YandexSpeechApi::Speed
