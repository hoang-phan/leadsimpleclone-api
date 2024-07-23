require "rails_helper"

module Mutations
  RSpec.describe "Save Lead", type: :request do
    describe ".resolve" do
      include_context "api user authenticated"

      let(:query) do
        <<~GRAPHQL
          mutation saveLead(
            $id: ID,
            $name: String,
            $emailsSent: Int,
            $callsMade: Int,
            $assigneeId: ID,
            $contactIds: [ID!],
            $stageId: ID
          ) {
            saveLead(input: {
              id: $id,
              name: $name,
              emailsSent: $emailsSent,
              callsMade: $callsMade,
              assigneeId: $assigneeId,
              contactIds: $contactIds,
              stageId: $stageId
            }) {
              id
              name
              emailsSent
              callsMade
              stage {
                id
                name
                color
              }
              assignee {
                id
                email
              }
              contacts {
                id
                firstName
              }
            }
          }
        GRAPHQL
      end
      let(:variables) do
        {
          id: id,
          name: name,
          emailsSent: emails_sent,
          callsMade: calls_made,
          assigneeId: user.id,
          contactIds: [contact.id],
          stageId: stage.id
        }
      end
      let!(:contact) { create(:contact) }
      let!(:stage) { create(:stage) }
      let(:emails_sent) { 5 }
      let(:calls_made) { 7 }
      let(:name) { Faker::Name.name }
      let(:json_response) { JSON(response.body).dig("data", "saveLead") }
      let(:expected_response) do
        {
          "id" => expected_id,
          "name" => name,
          "emailsSent" => emails_sent,
          "callsMade" => calls_made,
          "stage" => {
            "id" => stage.id.to_s,
            "name" => stage.name,
            "color" => stage.color
          },
          "assignee" => {
            "id" => user.id.to_s,
            "email" => user.email
          },
          "contacts" => [{
            "id" => contact.id.to_s,
            "firstName" => contact.first_name
          }]
        }
      end
      let(:id) { nil }
      let(:new_lead) { Lead.last }
      let(:expected_id) { new_lead.id.to_s }

      context "when id is present" do
        let!(:existing_lead) { create(:lead) }
        let(:id) { existing_lead.id }
        let(:expected_id) { existing_lead.id.to_s }

        it "updates lead" do
          expect do
            graphql query:, variables:, authorization:
          end.not_to change(Lead, :count)
          expect(json_response).to eq expected_response
        end
      end

      context "when id is absent" do
        it "creates new lead" do
          expect do
            graphql query:, variables:, authorization:
          end.to change(Lead, :count).by(1)
          expect(json_response).to eq expected_response
        end
      end
    end
  end
end
