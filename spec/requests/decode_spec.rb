# spec/requests/decode_spec.rb
require 'spec_helper'
require 'json'

RSpec.describe 'POST /decode' do
  it 'returns the original URL from code' do
    # encode first
    post '/encode',
         { url: 'https://example.com' }.to_json,
         { 'CONTENT_TYPE' => 'application/json' }

    code = JSON.parse(last_response.body)['code']

    post '/decode',
         { code: code }.to_json,
         { 'CONTENT_TYPE' => 'application/json' }

    expect(last_response.status).to eq(200)

    json = JSON.parse(last_response.body)
    expect(json['url']).to eq('https://example.com')
  end

  it 'returns 404 for unknown code' do
    post '/decode',
         { code: 'xyz123' }.to_json,
         { 'CONTENT_TYPE' => 'application/json' }

    expect(last_response.status).to eq(404)
  end
end
