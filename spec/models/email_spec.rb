require "rails_helper"

RSpec.describe Email, type: :model do
  describe "associations" do
    it { is_expected.to belong_to :contact }
  end

  describe "validations" do
    subject { build(:email) }

    it { is_expected.to validate_presence_of :value }
    it { is_expected.to validate_uniqueness_of(:value).scoped_to(:contact_id) }

    describe "email format" do
      subject { build(:email, value: value) }

      context "with valid format" do
        let(:value) { "test@email.com" }

        it { is_expected.to be_valid }
      end

      context "with invalid format" do
        let(:value) { "testemail.com" }

        it { is_expected.not_to be_valid }
      end
    end

    it_behaves_like "a contact kind"
  end
end
