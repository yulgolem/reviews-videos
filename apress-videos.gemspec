# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'apress/videos/version'

Gem::Specification.new do |spec|
  spec.metadata['allowed_push_host'] = 'https://gems.railsc.ru'

  spec.name          = 'apress-videos'
  spec.version       = Apress::Videos::VERSION
  spec.authors       = ['Alex Sherman']
  spec.email         = ['a.sherman.at.work@gmail.com']
  spec.description   = %q{Apress Company Videos}
  spec.summary       = %q{Gem to attach videos to reviews/comments/etc}
  spec.homepage      = 'https://github.com/abak-press/apress-videos'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = %w(lib)

  spec.add_runtime_dependency 'rails', '>= 3.1.12', '< 5'
  spec.add_runtime_dependency 'apress-api', '>= 1.8'
  spec.add_runtime_dependency 'pg'
  spec.add_runtime_dependency 'resque-integration', '>= 0.4.1'
  spec.add_runtime_dependency 'draper', '>= 1.3.0'
  spec.add_runtime_dependency 'active_hash', '>= 1.4.0'
  spec.add_runtime_dependency 'haml'

  spec.add_development_dependency 'bundler', '~> 1.7'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec', '>= 3.1'
  spec.add_development_dependency 'rspec-rails', '>= 2.14.0'
  spec.add_development_dependency 'appraisal', '>= 1.0.2'
  spec.add_development_dependency 'factory_girl_rails'
  spec.add_development_dependency 'combustion', '>= 0.5.4'
  spec.add_development_dependency 'shoulda-matchers', '< 3'
  spec.add_development_dependency 'rspec-html-matchers', '>= 0.7'
  spec.add_development_dependency 'simplecov', '>= 0.9'
  spec.add_development_dependency 'json-schema'
  spec.add_development_dependency 'mock_redis', '>= 0.15.3'
  spec.add_development_dependency 'webmock', '>= 1.24.2'
end
