FactoryBot.define do
  factory :lead_stage do
    association :lead
    association :stage, { kind: :lead }
  end
end
