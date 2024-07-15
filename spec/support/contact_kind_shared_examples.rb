require "rails_helper"

shared_examples_for "a contact kind" do
  describe "kind" do
    subject { build(:email, kind: kind) }

    Contact::CONTACT_KINDS.each do |kind|
      context "when kind is #{kind}" do
        let(:kind) { kind }

        it { is_expected.to be_valid }
      end
    end

    context "when kind is not in the list" do
      let(:kind) { "invalidkind" }

      it "raises enum error" do
        expect { subject }.to raise_error(ArgumentError)
      end
    end
  end
end
