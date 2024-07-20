require "rails_helper"

module Queries
  RSpec.describe "Users", type: :request do
    describe ".resolve" do
      include_context "api user authenticated"

      let!(:other_user) { create(:user) }

      let(:json_response) { JSON(response.body).dig("data", "users") }
      let(:expected_response) do
        [
          {
            "id" => user.id.to_s,
            "email" => user.email
          },
          {
            "id" => other_user.id.to_s,
            "email" => other_user.email
          }
        ]
      end

      it "returns paginated users" do
        graphql authorization:, query: <<~GRAPHQL
          {
            users {
              id
              email
            }
          }
        GRAPHQL

        expect(json_response).to match_array expected_response
      end
    end
  end
end
