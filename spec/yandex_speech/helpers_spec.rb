# encoding: utf-8

require 'spec_helper'

module YandexSpeechApi
  describe Helpers do
    context '#recognize_operation_system' do

      it "returns :windows for CONFIG['host_os'] == msys" do
        stub_const 'RbConfig::CONFIG', {'host_os' => 'msys'}
        expect(described_class.recognize_operation_system).to eql(:windows)
      end

      it "returns :mac_os for CONFIG['host_os'] == darwin" do
        stub_const 'RbConfig::CONFIG', {'host_os' => 'darwin'}
        expect(described_class.recognize_operation_system).to eql(:mac_os)
      end
    end # context '#recognize_operation_system'
  end # describe Helpers
end # module YandexSpeechApi
