require "rails_helper"

RSpec.describe User, type: :model do
  describe ".create_with_random_password" do
    let(:email) { Faker::Internet.email }

    subject { described_class.create_with_random_password(email) }
  
    it { is_expected.to be_a User }
    it { is_expected.to be_valid }
  end
end
