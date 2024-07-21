require "rails_helper"

module Mutations
  RSpec.describe "Delete Leads", type: :request do
    describe ".resolve" do
      include_context "api user authenticated"

      let!(:stage) { create(:stage) }
      let!(:existing_leads) { create_list(:lead, 2) }
      let(:json_response) { JSON(response.body).dig("data", "deleteLeads") }
      let(:query) do
        <<~GRAPHQL
          mutation deleteLeads($ids: [ID!]!) {
            deleteLeads(input: {
              ids: $ids
            }) {
              success
            }
          }
        GRAPHQL
      end

      it "deletes leads" do
        expect do
          graphql query:, variables: { ids: existing_leads.map(&:id).map(&:to_s) }, authorization:
        end.to change(Lead, :count).by(-2)

        expect(json_response["success"]).to be true
      end
    end
  end
end
