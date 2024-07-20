require "rails_helper"

module Queries
  RSpec.describe "Stages", type: :request do
    describe ".resolve" do
      include_context "api user authenticated"

      let!(:stage_1) { create(:stage, :lead, order: 0) }
      let!(:stage_2) { create(:stage, :lead, order: 1) }

      let(:json_response) { JSON(response.body).dig("data", "stages") }
      let(:expected_response) do
        [
          {
            "id" => stage_1.id.to_s,
            "name" => stage_1.name,
            "color" => stage_1.color
          },
          {
            "id" => stage_2.id.to_s,
            "name" => stage_2.name,
            "color" => stage_2.color
          }
        ]
      end

      it "returns paginated stages" do
        graphql authorization:, query: <<~GRAPHQL
          {
            stages {
              id
              name
              color
            }
          }
        GRAPHQL

        expect(json_response).to eq expected_response
      end
    end
  end
end
