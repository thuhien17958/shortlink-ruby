module JsonHelpers
  def json(data, status = 200)
    halt status, data.to_json
  end

  def parse_json
    return {} if request.request_method == 'GET'

    raw = request.body&.read.to_s
    return {} if raw.empty?

    JSON.parse(raw)
  rescue JSON::ParserError
    halt_json 400, error: 'invalid_json'
  end
end
