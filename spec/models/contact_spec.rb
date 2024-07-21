require 'rails_helper'

RSpec.describe Contact, type: :model do
  describe "associations" do
    it { is_expected.to belong_to(:source).optional }
    it { is_expected.to have_many(:lead_contacts).dependent(:destroy) }
    it { is_expected.to have_many(:leads).through(:lead_contacts) }
  end

  describe "validations" do
    it { is_expected.to validate_presence_of :first_name }
    it { is_expected.to validate_presence_of :last_name }
  end
end
