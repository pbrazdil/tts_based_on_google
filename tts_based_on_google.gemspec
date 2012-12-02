# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'tts_based_on_google/version'

Gem::Specification.new do |gem|
  gem.name          = "tts_based_on_google"
  gem.version       = TTSBasedOnGoogle::VERSION
  gem.authors       = ["Petr Brazdil"]
  gem.email         = ["p.brazdil@gmail.com"]
  gem.description   = %q{Provides Text-to-speech functionality in many languages. Results can be stored into MP3 file or send to output. Based on technologies from Google.}
  gem.summary       = %q{Provides Text-to-speech functionality in many languages. Results can be stored into MP3 file.}
  gem.homepage      = "https://github.com/pbrazdil/tts_based_on_google"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
end
