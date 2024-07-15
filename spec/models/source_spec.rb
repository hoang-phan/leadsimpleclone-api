require "rails_helper"

RSpec.describe Source, type: :model do
  describe "validations" do
    subject { build(:source) }

    it { is_expected.to validate_presence_of :name }
    it { is_expected.to validate_uniqueness_of :name }
  end
end
