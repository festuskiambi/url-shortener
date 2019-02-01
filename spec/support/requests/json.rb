module Json
  def json
    JSON.parse(response.body)
  end
end