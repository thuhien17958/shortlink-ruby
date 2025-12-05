# spec/models/url_spec.rb
require 'spec_helper'

RSpec.describe Url do
  it 'creates a new DB row' do
    record = Url.create(long_url: 'https://ruby.com')
    expect(record.long_url).to eq('https://ruby.com')
    expect(record.id).not_to be_nil
  end

  it 'finds by URL' do
    Url.create(long_url: 'https://ruby.com')
    record = Url.find_by_long_url('https://ruby.com')

    expect(record.long_url).to eq('https://ruby.com')
  end

  it 'finds by code' do
    r = Url.create(long_url: 'https://ruby.com')
    r.update_code('XYZ')

    expect(Url.find_by_code('XYZ').long_url).to eq('https://ruby.com')
  end
end
