FactoryBot.define do
  factory :lead_contact do
    association :lead
    association :contact
  end
end
