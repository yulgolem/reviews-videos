# coding: utf-8

require 'bundler/setup'

require 'simplecov'
SimpleCov.start 'rails' do
  minimum_coverage 95
  add_filter 'lib/apress/videos/version.rb'
  add_filter 'app/docs'
end

require 'apress/videos'

require 'combustion'
Combustion.initialize! :all do
  config.i18n.enforce_available_locales = false
  config.i18n.default_locale = :ru
end

require 'rspec/rails'
require 'apress/api/testing/json_matcher'
require 'factory_girl_rails'
require 'shoulda-matchers'
require 'rspec-html-matchers'
require 'webmock/rspec'
require 'mock_redis'
redis = MockRedis.new
Redis.current = redis
Resque.redis = redis

RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods
  config.include ActionDispatch::TestProcess
  config.include RSpecHtmlMatchers
  config.use_transactional_fixtures = true
  config.filter_run_including focus: true
  config.run_all_when_everything_filtered = true
end
