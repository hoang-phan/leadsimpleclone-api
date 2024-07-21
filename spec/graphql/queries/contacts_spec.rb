require "rails_helper"

module Queries
  RSpec.describe "Contacts", type: :request do
    describe ".resolve" do
      include_context "api user authenticated"

      let!(:contact_1) { create(:contact) }
      let!(:contact_2) { create(:contact) }
      let!(:stage) { create(:stage) }
      let!(:lead) { create(:lead, contacts: [contact_1]) }

      let(:json_response) { JSON(response.body).dig("data", "contacts") }
      let(:expected_response) do
        [{
          "node" => {
            "id" => contact_1.id.to_s,
            "firstName" => contact_1.first_name,
            "lastName" => contact_1.last_name,
            "companyName" => contact_1.company_name,
            "name" => contact_1.name,
            "leadsCount" => 1,
            "source" => {
              "id" => contact_1.source.id.to_s,
              "name" => contact_1.source.name
            }
          }
        }]
      end

      it "returns paginated contacts" do
        graphql authorization:, query: <<~GRAPHQL
          {
            contacts(first: 1) {
              edges {
                node {
                  id
                  name
                  firstName
                  lastName
                  companyName
                  leadsCount
                  source {
                    id
                    name
                  }
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
