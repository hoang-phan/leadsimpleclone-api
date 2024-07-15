def graphql(query:, variables: nil, authorization: nil)
  post "/graphql",
    params: { query:, variables: }.to_json,
    headers: {
      "CONTENT_TYPE" => "application/json",
      "ACCEPT" => "application/json",
      "Authorization" => authorization
    }
end
