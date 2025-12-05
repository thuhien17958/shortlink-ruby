# spec/services/url_shortener_spec.rb
require 'spec_helper'

RSpec.describe UrlShortener do
  let(:service) { UrlShortener.new }

  it 'creates new short code' do
    result = service.encode('https://abc.com')
    expect(result[:code]).not_to be_nil
  end

  it 'reuses code for duplicate URLs' do
    a = service.encode('https://abc.com')
    b = service.encode('https://abc.com')

    expect(a[:code]).to eq(b[:code])
  end

  it 'decodes a valid code' do
    encoded = service.encode('https://abc.com')
    decoded = service.decode(encoded[:code])

    expect(decoded[:url]).to eq('https://abc.com')
  end

  it 'returns nil for unknown code' do
    decoded = service.decode('nonexistent')
    expect(decoded).to be_nil
  end
end
