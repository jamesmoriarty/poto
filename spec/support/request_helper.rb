def last_response_as_json
  JSON.parse(last_response.body, symbolize_names: true)
end
