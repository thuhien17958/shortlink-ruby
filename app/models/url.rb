# app/models/url.rb
require_relative '../../config/database'

class Url
  def self.dataset
    URLS
  end

  def self.create(long_url:)
    id = dataset.insert(long_url: long_url, created_at: Time.now)
    new(dataset.where(id: id).first)
  end

  def self.find_by_long_url(url)
    row = dataset.where(long_url: url).first
    row ? new(row) : nil
  end

  def self.find_by_code(code)
    row = dataset.where(code: code).first
    row ? new(row) : nil
  end

  def initialize(row)
    @row = row
  end

  def id        = @row[:id]
  def code      = @row[:code]
  def long_url  = @row[:long_url]

  def update_code(code)
    self.class.dataset.where(id: id).update(code: code)
    @row[:code] = code
  end
end
