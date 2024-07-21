require "rails_helper"

module Mutations
  RSpec.describe "Create Leads from Contacts", type: :request do
    describe ".resolve" do
      include_context "api user authenticated"

      let(:query) do
        <<~GRAPHQL
          mutation createLeadsFromContacts(
            $contactIds: [ID!]!,
            $stageId: ID!,
            $assigneeId: ID!
          ) {
            createLeadsFromContacts(input: {
              contactIds: $contactIds,
              stageId: $stageId,
              assigneeId: $assigneeId
            }) {
              success
            }
          }
        GRAPHQL
      end
      let(:variables) do
        {
          contactIds: [contact_1.id.to_s, contact_2.id.to_s],
          stageId: stage.id.to_s,
          assigneeId: assignee.id.to_s,
        }
      end
      let!(:contact_1) { create(:contact) }
      let!(:contact_2) { create(:contact) }
      let!(:stage) { create(:stage) }
      let!(:assignee) { create(:user) }

      let(:json_response) { JSON(response.body).dig("data", "createLeadsFromContacts") }

      it "creates new leads from selected contacts" do
        expect do
          graphql query:, variables:, authorization:
        end.to change(Lead, :count).by(2)
        expect(json_response["success"]).to be true
        expect(Lead).to exist contact: contact_1, stage:, assignee:
        expect(Lead).to exist contact: contact_2, stage:, assignee:
      end
    end
  end
end
