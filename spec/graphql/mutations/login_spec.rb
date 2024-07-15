require "rails_helper"

module Mutations
  RSpec.describe "Login", type: :request do
    describe ".resolve" do
      let!(:user) { create(:user, password: password, password_confirmation: password) }
      let(:password) { SecureRandom.uuid }
      let(:json_response) { JSON(response.body).dig("data", "login") }
      let(:query) do
        <<~GRAPHQL
          mutation login(
            $email: String!,
            $password: String!
          ) {
            login(input: {
              email: $email,
              password: $password,
            }) {
              token
              error
            }
          }
        GRAPHQL
      end
      let(:variables) do
        { email: email, password: input_password }
      end
      let(:email) { user.email }
      let(:input_password) { password }

      before do
        graphql query:, variables:
      end

      context "when email is invalid" do
        let(:email) { Faker::Internet.email }

        it "returns unauthenticated error" do
          expect(json_response["token"]).to be_blank
          expect(json_response["error"]).to eq "Invalid email or password"
        end
      end

      context "when password is invalid" do
        let(:input_password) { "InvalidPassword" }

        it "returns unauthenticated error" do
          expect(json_response["token"]).to be_blank
          expect(json_response["error"]).to eq "Invalid email or password"
        end
      end

      context "when email and password are valid" do
        it "returns the token" do
          expect(json_response["token"]).to eq JWT.encode(user.id.to_s, ENV["SECRET_TOKEN"])
          expect(json_response["error"]).to be_blank
        end
      end
    end
  end
end
