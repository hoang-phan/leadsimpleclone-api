require "rails_helper"

module Mutations
  RSpec.describe "Delete Contact", type: :request do
    describe ".resolve" do
      let!(:existing_contact) { create(:contact) }
      let(:json_response) { JSON(response.body).dig("data", "deleteContact") }
      let(:query) do
        <<~GRAPHQL
          mutation deleteContact(
            $id: ID!
          ) {
            deleteContact(input: {
              id: $id
            }) {
              success
            }
          }
        GRAPHQL
      end

      it "deletes contact" do
        expect do
          graphql query:, variables: { id: existing_contact.id }
        end.to change(Contact, :count).by(-1)

        expect(json_response["success"]).to be true
      end
    end
  end
end
