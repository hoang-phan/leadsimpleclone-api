require 'rails_helper'

RSpec.describe Stage, type: :model do
  describe "associations" do
    it { is_expected.to have_many(:lead_stages) }
  end

  describe "validations" do
    subject { build(:stage) }
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_uniqueness_of(:name).scoped_to(:kind) }
  end

  describe "callbacks" do
    describe "before_destroy" do
      describe "#reassign_lead_stages" do
        let!(:stage_1) { create(:stage) }
        let!(:stage_2) { create(:stage) }
        let!(:lead_stage_1) { create(:lead_stage, stage: stage_1) }

        it "reassigns the lead stages to the first remaining lead stage" do
          stage_1.destroy
          expect(lead_stage_1.reload.stage).to eq stage_2
        end
      end
    end
  end
end
