# encoding: utf-8
guard :rspec, cmd: "bundle exec rspec" do
  watch(/^lib\/ifs.rb$/) { "spec/yandex_speech_speech" }
  watch("spec/spec_helper.rb") { "spec" }
  watch(/^spec\/.+_spec\.rb$/)
  watch(/^lib\/(.+)\.rb$/) {|m| "spec/#{m[1]}_spec.rb" }
end
