require "rails_helper"

shared_context "api user authenticated" do
  let!(:user) { create(:user) }
  let(:access_token) { JsonWebToken.from_user(user) }
  let(:authorization) { "Bearer #{access_token}" }
end
