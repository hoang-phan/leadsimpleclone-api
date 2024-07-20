require 'rails_helper'

RSpec.describe LeadContact, type: :model do
  describe "associations" do
    it { is_expected.to belong_to(:lead) }
    it { is_expected.to belong_to(:contact) }
  end
end
