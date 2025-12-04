require 'sinatra'
require 'json'
require_relative 'config/database'
require_relative 'lib/shortener'

set :environment, ENV.fetch('RACK_ENV', 'development').to_sym

before do
  content_type :json
end

helpers do
  def json_body
    body = request.body.read
    begin
      body.empty? ? {} : JSON.parse(body)
    rescue StandardError
      {}
    end
  end
end

post '/encode' do
  payload = json_body
  long_url = payload['url'] || payload['long_url']

  halt 400, { error: 'missing url' }.to_json if long_url.to_s.strip.empty?
  halt 400, { error: 'url must start with http:// or https://' }.to_json unless long_url =~ %r{\Ahttps?://}

  existing = URLS.where(long_url: long_url).first
  return { code: existing[:code], url: long_url }.to_json if existing

  id = URLS.insert(long_url: long_url, created_at: Time.now)
  short_code = encode_base62(obfuscate_id(id))

  URLS.where(id: id).update(code: short_code)

  { code: short_code, url: long_url }.to_json
end

post '/decode' do
  payload = json_body
  code = payload['code']
  halt 400, { error: 'missing code' }.to_json if code.to_s.strip.empty?

  row = URLS.where(code: code).first
  halt 404, { error: 'not found' }.to_json unless row

  { code: code, url: row[:long_url] }.to_json
end

Sinatra::Application.run! if __FILE__ == $0
