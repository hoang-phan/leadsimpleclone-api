require "rails_helper"

module Queries
  RSpec.describe "Source", type: :request do
    describe ".resolve" do
      include_context "api user authenticated"

      let!(:source) { create(:source) }

      let(:json_response) { JSON(response.body).dig("data", "source") }
      let(:expected_response) do
        {
          "id" => source.id.to_s,
          "name" => source.name
        }
      end

      it "returns source for provided id" do
        graphql authorization:, query: <<~GRAPHQL
          query {
            source(id: #{source.id}) {
              id
              name
            }
          }
        GRAPHQL

        expect(json_response).to eq expected_response
      end
    end
  end
end
