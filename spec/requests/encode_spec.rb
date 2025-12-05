# spec/requests/encode_spec.rb
require 'spec_helper'
require 'json'

RSpec.describe 'POST /encode' do
  it 'creates a short code for a new URL' do
    post '/encode',
         { url: 'https://google.com' }.to_json,
         { 'CONTENT_TYPE' => 'application/json' }

    expect(last_response.status).to eq(200)

    json = JSON.parse(last_response.body)
    expect(json['code']).not_to be_nil
    expect(json['url']).to eq('https://google.com')
  end

  it 'reuses the same code for duplicate URLs' do
    post '/encode',
         { url: 'https://google.com' }.to_json,
         { 'CONTENT_TYPE' => 'application/json' }

    first_code = JSON.parse(last_response.body)['code']

    post '/encode',
         { url: 'https://google.com' }.to_json,
         { 'CONTENT_TYPE' => 'application/json' }

    second_code = JSON.parse(last_response.body)['code']

    expect(second_code).to eq(first_code)
  end
end
