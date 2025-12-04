require_relative 'spec_helper'
require 'json'

RSpec.describe 'Shortener API' do
  #
  # --- /encode ---
  #

  it 'encodes a valid URL' do
    post '/encode', { url: 'https://example.com' }.to_json,
         { 'CONTENT_TYPE' => 'application/json' }

    expect(last_response.status).to eq(200)

    body = JSON.parse(last_response.body)
    expect(body['code']).not_to be_nil
    expect(body['url']).to eq('https://example.com')

    # Check it really writes to DB
    row = URLS.where(code: body['code']).first
    expect(row).not_to be_nil
    expect(row[:long_url]).to eq('https://example.com')
  end

  it 'rejects missing url' do
    post '/encode', {}.to_json,
         { 'CONTENT_TYPE' => 'application/json' }

    expect(last_response.status).to eq(400)
  end

  it 'rejects invalid url without http/https' do
    post '/encode', { url: 'google.com' }.to_json,
         { 'CONTENT_TYPE' => 'application/json' }

    expect(last_response.status).to eq(400)
  end

  #
  # --- /decode ---
  #

  it 'decodes a valid code' do
    # create encoded url first
    post '/encode', { url: 'https://example.com/test' }.to_json,
         { 'CONTENT_TYPE' => 'application/json' }

    code = JSON.parse(last_response.body)['code']

    # decode
    post '/decode', { code: code }.to_json,
         { 'CONTENT_TYPE' => 'application/json' }

    expect(last_response.status).to eq(200)

    body = JSON.parse(last_response.body)
    expect(body['url']).to eq('https://example.com/test')
  end

  it 'returns 400 when missing code' do
    post '/decode', {}.to_json,
         { 'CONTENT_TYPE' => 'application/json' }

    expect(last_response.status).to eq(400)
  end

  it 'returns 404 for unknown code' do
    post '/decode', { code: 'notexist' }.to_json,
         { 'CONTENT_TYPE' => 'application/json' }

    expect(last_response.status).to eq(404)
  end
end
