require 'rails_helper'

RSpec.describe LeadStage, type: :model do
  describe "associations" do
    it { is_expected.to belong_to(:lead) }
    it { is_expected.to belong_to(:stage) }
  end
end
