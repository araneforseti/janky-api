require 'rspec'
require 'redis'
require 'rack/test'

include Rack::Test::Methods

ENV['RACK_ENV'] = 'test'

require File.expand_path '../../janky_api.rb', __FILE__

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.before(:each) do
    @redis = Redis.new
    keys = @redis.keys('*')
    keys.each{ |key| @redis.del(key)}
  end

  config.warnings = true
  config.order = :random
end

def app
  Sinatra::Application
end

def get url
  Rack::Test::Session.new(Rack::MockSession.new(Sinatra::Application))
  browser.get url
end
