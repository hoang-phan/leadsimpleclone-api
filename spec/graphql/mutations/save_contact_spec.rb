require "rails_helper"

module Mutations
  RSpec.describe "Create Or Update Contact", type: :request do
    describe ".resolve" do
      include_context "api user authenticated"

      let(:query) do
        <<~GRAPHQL
          mutation saveContact(
            $id: ID,
            $firstName: String!,
            $lastName: String!,
            $companyName: String,
            $emails: [EmailInput!],
            $phones: [PhoneInput!],
            $sourceId: ID
          ) {
            saveContact(input: {
              id: $id,
              firstName: $firstName,
              lastName: $lastName,
              companyName: $companyName,
              emails: $emails,
              phones: $phones,
              sourceId: $sourceId
            }) {
              id
              firstName
              lastName
              companyName
              source {
                id
                name
              }
              emails {
                value
                kind
              }
              phones {
                value
                kind
              }
            }
          }
        GRAPHQL
      end
      let(:variables) do
        {
          id: id,
          firstName: first_name,
          lastName: last_name,
          companyName: company_name,
          emails: emails_attributes,
          phones: phones_attributes,
          sourceId: source.id.to_s
        }
      end
      let!(:source) { create(:source) }
      let(:first_name) { Faker::Name.first_name }
      let(:last_name) { Faker::Name.last_name }
      let(:company_name) { Faker::Company.name }
      let(:email) { Faker::Internet.email }
      let(:phone) { Faker::PhoneNumber.phone_number }
      let(:emails_attributes) { [{ value: email, kind: "personal" }] }
      let(:phones_attributes) { [{ value: phone, kind: "work" }] }
      let(:json_response) { JSON(response.body).dig("data", "saveContact") }
      let(:expected_response) do
        {
          "id" => expected_id,
          "firstName" => first_name,
          "lastName" => last_name,
          "companyName" => company_name,
          "source" => {
            "id" => source.id.to_s,
            "name" => source.name
          },
          "emails" => [{
            "value" => email,
            "kind" => "personal"
          }],
          "phones" => [{
            "value" => phone,
            "kind" => "work"
          }]
        }
      end
      let(:id) { nil }
      let(:new_contact) { Contact.last }
      let(:expected_id) { new_contact.id.to_s }

      context "when id is present" do
        let!(:existing_contact) { create(:contact) }
        let!(:existing_email) { create(:email, contact: existing_contact) }
        let(:emails_attributes) do
          [
            { id: existing_email.id, _destroy: "1" },
            { value: email, kind: "personal" }
          ]
        end
        let(:id) { existing_contact.id }
        let(:expected_id) { existing_contact.id.to_s }

        it "updates contact" do
          expect do
            graphql query:, variables:, authorization:
          end.not_to change(Contact, :count)
          expect(json_response).to eq expected_response
        end
      end

      context "when id is absent" do
        it "creates new contact" do
          expect do
            graphql query:, variables:, authorization:
          end.to change(Contact, :count).by(1)
          expect(json_response).to eq expected_response
        end
      end
    end
  end
end
