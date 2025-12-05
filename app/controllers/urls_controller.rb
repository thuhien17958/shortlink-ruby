# app/controllers/urls_controller.rb
require 'sinatra/base'
require_relative '../../config/database'
require_relative '../services/url_shortener'
require_relative '../concerns/json_helpers'
require_relative '../concerns/error_helpers'

class UrlsController < Sinatra::Base
  helpers JsonHelpers, ErrorHelpers

  before do
    content_type :json
    @payload = parse_json
  end

  post '/encode' do
    long_url = @payload['url'] || @payload['long_url']
    halt_json 400, error: 'missing url' if blank?(long_url)

    service = UrlShortener.new
    result  = service.encode(long_url)

    json result
  end

  post '/decode' do
    code = @payload['code']
    halt_json 400, error: 'missing code' if blank?(code)

    service = UrlShortener.new
    result  = service.decode(code)

    halt_json 404, error: 'not found' unless result

    json result
  end

  # Optional redirect endpoint
  get '/:code' do
    service = UrlShortener.new
    result  = service.decode(params[:code])

    halt 404, 'Not found' unless result
    redirect result[:url], 302
  end

  private

  def blank?(value)
    value.nil? || value.to_s.strip.empty?
  end
end
