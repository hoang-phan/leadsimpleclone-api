require "rails_helper"

module Queries
  RSpec.describe "Sources", type: :request do
    describe ".resolve" do
      let!(:source_1) { create(:source) }
      let!(:source_2) { create(:source) }

      let(:json_response) { JSON(response.body).dig("data", "sources") }
      let(:expected_response) do
        [{
          "node" => {
            "id" => source_1.id.to_s,
            "name" => source_1.name
          }
        }]
      end

      it "returns paginated sources" do
        graphql query: <<~GRAPHQL
          {
            sources(first: 1) {
              edges {
                node {
                  id
                  name
                }
              }
              pageInfo {
                hasNextPage
              }
            }
          }
        GRAPHQL

        expect(json_response["edges"]).to eq expected_response
        expect(json_response["pageInfo"]["hasNextPage"]).to be true
      end
    end
  end
end
