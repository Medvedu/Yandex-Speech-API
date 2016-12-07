# encoding: utf-8

require 'spec_helper'

module YandexSpeechApi
  describe Speed do
    context '#new' do
      it 'creates instance with :standard value by default' do
        speed_instance = described_class.new
        expect(speed_instance.value).to_not be_nil
      end

      it 'raises an exception for unknown speed mode' do
        expect{ described_class.new :lol }
          .to raise_exception described_class::SpeedModeNotAllowed
      end

      it "creates object instance when +speed+ is a symbol" do
         expect(described_class.new :slowest).to be
      end

      it "creates object instance when +speed+ is an integer" do
          expect(described_class.new 2.45).to be
      end

      it "raises an exception when +speed+ is not in allowed range" do
        expect { described_class.new 5000 }
          .to raise_exception described_class::SpeedValueNotInRange
      end
    end # context #new

    context '#list' do
      it 'shows list of allowed speed modes' do
        expect(described_class.modes).to_not be_nil
      end
    end # context #list
  end # describe Speed
end # module YandexSpeechApi
