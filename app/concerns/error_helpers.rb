module ErrorHelpers
  def halt_json(status, data)
    halt status, data.to_json
  end
end
