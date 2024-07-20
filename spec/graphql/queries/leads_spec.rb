require "rails_helper"

module Queries
  RSpec.describe "Leads", type: :request do
    describe ".resolve" do
      include_context "api user authenticated"

      let!(:user) { create(:user) }
      let!(:contact_1) { create(:contact) }
      let!(:stage_1) { create(:stage) }
      let!(:lead_1) { create(:lead, contacts: [contact_1], assignee: user) }
      let!(:lead_2) { create(:lead) }

      let(:json_response) { JSON(response.body).dig("data", "leads") }
      let(:expected_response) do
        [{
          "node" => {
            "id" => lead_1.id.to_s,
            "emailsSent" => lead_1.emails_sent,
            "callsMade" => lead_1.calls_made,
            "contacts" => [{
              "id" => contact_1.id.to_s,
              "firstName" => contact_1.first_name,
              "lastName" => contact_1.last_name,
              "companyName" => contact_1.company_name,  
            }],
            "stage" => {
              "id" => stage_1.id.to_s,
              "name" => stage_1.name
            },
            "assignee" => {
              "id" => user.id.to_s,
              "email" => user.email,
            }
          }
        }]
      end

      before do
        lead_1.lead_stage.update(stage: stage_1)
      end

      it "returns paginated contacts" do
        graphql authorization:, query: <<~GRAPHQL
          {
            leads(first: 1) {
              edges {
                node {
                  id
                  emailsSent
                  callsMade
                  contacts {
                    id
                    firstName
                    lastName
                    companyName
                  }
                  stage {
                    id
                    name
                  }
                  assignee {
                    id
                    email
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
