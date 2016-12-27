# encoding: utf-8

require 'spec_helper'

##
# Skips tests when OS-platform is not unix-like.
#
# @return [TrueClass, FalseClass]
#   +True+ and tests below be SKIPPED.
#   +False+ otherwise.

def depends_on_platform
  !(RbConfig::CONFIG['host_os'] =~ /linux/)
end

# ----------------------------------------------------

module YandexSpeechApi
module MP3_Player
  describe Linux_MP3_Player, disabled: depends_on_platform do
    context '#play' do
      before :each do # stub parent class methods
        expect_any_instance_of(described_class)
          .to receive(:validate_file_presence).and_return nil

        expect_any_instance_of(described_class)
          .to receive(:validate_mp3_format).and_return nil
      end

      it 'raises an exception when mpg123 not found' do
        allow(Helpers).to receive(:find_executable).and_return nil

        expect{described_class.new.play('lalalala.')}
          .to raise_exception described_class::ApplicationNotInstalled
      end
    end # context '#play'
  end # describe Linux_MP3_Player
end # module MP3_Player
end # module YandexSpeechApi
