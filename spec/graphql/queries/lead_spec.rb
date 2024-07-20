require "rails_helper"

module Queries
  RSpec.describe "Lead", type: :request do
    describe ".resolve" do
      include_context "api user authenticated"

      let!(:user) { create(:user) }
      let!(:contact) { create(:contact) }
      let!(:stage) { create(:stage) }
      let!(:lead) { create(:lead, contacts: [contact], assignee: user) }

      let(:json_response) { JSON(response.body).dig("data", "lead") }
      let(:expected_response) do
        {
          "id" => lead.id.to_s,
          "emailsSent" => lead.emails_sent,
          "callsMade" => lead.calls_made,
          "contacts" => [{
            "id" => contact.id.to_s,
            "firstName" => contact.first_name,
            "lastName" => contact.last_name,
            "companyName" => contact.company_name,  
          }],
          "stage" => {
            "id" => stage.id.to_s,
            "name" => stage.name
          },
          "assignee" => {
            "id" => user.id.to_s,
            "email" => user.email,
          }
        }
      end

      before do
        lead.lead_stage.update(stage: stage)
      end

      it "returns lead for the id" do
        graphql authorization:, query: <<~GRAPHQL
          query {
            lead(id: #{lead.id}) {
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
        GRAPHQL

        expect(json_response).to eq expected_response
      end
    end
  end
end
