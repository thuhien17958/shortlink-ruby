# app.rb
require 'sinatra/base'
require_relative './app/controllers/urls_controller'

class App < Sinatra::Base
  use UrlsController

  # Correct Rack app for test environment
  def self.app
    Rack::Builder.new do
      map '/' do
        run UrlsController.new
      end
    end
  end
end
