def graphql(query:, variables: nil)
  post "/graphql",
    params: { query:, variables: }.to_json,
    headers: {
      "CONTENT_TYPE" => "application/json",
      "ACCEPT" => "application/json"
    }
end
