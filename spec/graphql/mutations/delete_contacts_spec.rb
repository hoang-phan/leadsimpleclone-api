require "rails_helper"

module Mutations
  RSpec.describe "Delete Contacts", type: :request do
    describe ".resolve" do
      include_context "api user authenticated"

      let!(:existing_contacts) { create_list(:contact, 2) }
      let(:json_response) { JSON(response.body).dig("data", "deleteContacts") }
      let(:query) do
        <<~GRAPHQL
          mutation deleteContacts($ids: [ID!]!) {
            deleteContacts(input: {
              ids: $ids
            }) {
              success
            }
          }
        GRAPHQL
      end

      it "deletes contacts" do
        expect do
          graphql query:, variables: { ids: existing_contacts.map(&:id).map(&:to_s) }, authorization:
        end.to change(Contact, :count).by(-2)

        expect(json_response["success"]).to be true
      end
    end
  end
end
