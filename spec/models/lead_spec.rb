require 'rails_helper'

RSpec.describe Lead, type: :model do
  describe "associations" do
    it { is_expected.to have_one(:lead_stage).dependent(:destroy) }
    it { is_expected.to have_one(:stage).through(:lead_stage) }
    it { is_expected.to have_many(:lead_contacts).dependent(:destroy) }
    it { is_expected.to have_many(:contacts).through(:lead_contacts) }
  end
end
