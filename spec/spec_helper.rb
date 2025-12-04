require 'rack/test'
require 'rspec'

# Set environment so Sinatra doesn't run production mode
ENV['RACK_ENV'] = 'test'

# Load the app (this should NOT auto-start server)
require_relative '../app'
require_relative '../config/database'

RSpec.configure do |config|
  config.include Rack::Test::Methods

  # Sinatra test app
  def app
    Sinatra::Application
  end

  # DB cleanup before each test
  config.before(:each) do
    URLS.delete if URLS
  end
end
