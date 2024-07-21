require "rails_helper"

module Mutations
  RSpec.describe "Merge Contacts", type: :request do
    describe ".resolve" do
      include_context "api user authenticated"

      let(:query) do
        <<~GRAPHQL
          mutation mergeContacts(
            $contactIds: [ID!]!,
            $primaryContactId: ID!
          ) {
            mergeContacts(input: {
              contactIds: $contactIds,
              primaryContactId: $primaryContactId
            }) {
              success
            }
          }
        GRAPHQL
      end
      let(:variables) do
        {
          contactIds: [contact_1.id.to_s, contact_2.id.to_s],
          primaryContactId: contact_1.id.to_s
        }
      end
      let!(:stage) { create(:stage) }
      let!(:contact_1) { create(:contact) }
      let!(:email_11) { create(:email, value: "test1@test.com", kind: "work", contact: contact_1) }
      let!(:email_12) { create(:email, value: "test2@test.com", kind: "personal", contact: contact_1) }
      let!(:phone_11) { create(:phone, value: "111111111", kind: "personal", contact: contact_1) }
      let!(:phone_12) { create(:phone, value: "222222222", kind: "work", contact: contact_1) }
      let!(:lead_11) { create(:lead, contacts: [contact_1]) }
      let!(:lead_12) { create(:lead, contacts: [contact_1]) }
      let!(:contact_2) { create(:contact) }
      let!(:email_21) { create(:email, value: "test2@test.com", kind: "personal", contact: contact_2) }
      let!(:email_22) { create(:email, value: "test3@test.com", kind: "work", contact: contact_2) }
      let!(:phone_21) { create(:phone, value: "333333333", kind: "personal", contact: contact_2) }
      let!(:lead_21) { create(:lead, contacts: [contact_2]) }

      let(:json_response) { JSON(response.body).dig("data", "mergeContacts") }
      let(:new_leads) { Lead.last(2) }

      it "merge contacts and keep every information from primary contact" do
        expect do
          graphql query:, variables:, authorization:
        end.to change(Contact, :count).by(-1)
        expect(json_response["success"]).to be true

        expect(Contact).not_to exist(id: contact_2.id)
        expect(Contact).to exist(id: contact_1.id)
        expect(contact_1.reload.leads).to match_array [lead_11, lead_12, lead_21]
        expect(contact_1.reload.emails).to match_array [email_11, email_12, email_22]
        expect(contact_1.reload.phones).to match_array [phone_11, phone_12, phone_21]
      end
    end
  end
end
