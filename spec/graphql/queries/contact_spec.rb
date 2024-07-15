require "rails_helper"

module Queries
  RSpec.describe "Contact", type: :request do
    describe ".resolve" do
      include_context "api user authenticated"

      let!(:contact) { create(:contact) }
      let!(:email) { create(:email, contact: contact) }
      let!(:phone) { create(:phone, contact: contact) }

      let(:json_response) { JSON(response.body).dig("data", "contact") }
      let(:expected_response) do
        {
          "id" => contact.id.to_s,
          "firstName" => contact.first_name,
          "lastName" => contact.last_name,
          "companyName" => contact.company_name,
          "source" => {
            "id" => contact.source.id.to_s,
            "name" => contact.source.name
          },
          "emails" => [{
            "value" => email.value,
            "kind" => email.kind
          }],
          "phones" => [{
            "value" => phone.value,
            "kind" => phone.kind
          }]
        }
      end

      it "returns contact for provided id" do
        graphql authorization:, query: <<~GRAPHQL
          query {
            contact(id: #{contact.id}) {
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

        expect(json_response).to eq expected_response
      end
    end
  end
end
