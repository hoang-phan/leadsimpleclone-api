require "rails_helper"

RSpec.describe Phone, type: :model do
  describe "associations" do
    it { is_expected.to belong_to :contact }
  end

  describe "validations" do
    subject { build(:phone) }

    it { is_expected.to validate_presence_of :value }
    it { is_expected.to validate_uniqueness_of(:value).scoped_to(:contact_id).case_insensitive }

    describe "phone format" do
      subject { build(:phone, value: value) }

      context "with valid format" do
        let(:value) { "+91 (123) 456-7890" }

        it { is_expected.to be_valid }
      end

      context "with invalid format" do
        let(:value) { "123 invalid 24567" }

        it { is_expected.not_to be_valid }
      end
    end

    it_behaves_like "a contact kind"
  end
end
