# spec/requests/redirect_spec.rb
require 'spec_helper'

RSpec.describe 'GET /:code redirect' do
  it 'redirects to the original URL' do
    post '/encode',
         { url: 'https://my-site.com' }.to_json,
         { 'CONTENT_TYPE' => 'application/json' }

    code = JSON.parse(last_response.body)['code']

    get "/#{code}"

    expect(last_response.status).to eq(302)
    expect(last_response.headers['Location']).to eq('https://my-site.com')
  end

  it 'returns 404 for unknown code' do
    get '/unknown123'
    expect(last_response.status).to eq(404)
  end
end
