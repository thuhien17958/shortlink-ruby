# app/services/url_shortener.rb
require_relative '../../lib/shortener'
require_relative '../models/url'

class UrlShortener
  def encode(long_url)
    existing = Url.find_by_long_url(long_url)
    return { code: existing.code, url: long_url } if existing

    record    = Url.create(long_url: long_url)
    short_id  = obfuscate_id(record.id)
    short_code = encode_base62(short_id)

    record.update_code(short_code)

    { code: short_code, url: long_url }
  end

  def decode(code)
    record = Url.find_by_code(code)
    return nil unless record

    { code: code, url: record.long_url }
  end
end
