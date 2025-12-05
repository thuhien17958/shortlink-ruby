# spec/spec_helper.rb
require 'rspec'
require 'rack/test'

ENV['RACK_ENV'] = 'test'

# Load Sinatra modular app
require_relative '../app'

# Load DB setup
require_relative '../config/database'

RSpec.configure do |config|
  config.include Rack::Test::Methods

  # IMPORTANT: return a Rack application, not Sinatra class
  def app
    App.app   # ← This must exist in app.rb
  end

  config.before(:each) do
    URLS.delete
  end
end
