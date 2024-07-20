FactoryBot.define do
  factory :lead do
    emails_sent { 0 }
    calls_made { 0 }
    association :assignee, factory: :user
  end
end
