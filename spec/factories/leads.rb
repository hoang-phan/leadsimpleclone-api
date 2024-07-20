FactoryBot.define do
  factory :lead do
    name { Faker::Name.name }
    emails_sent { 0 }
    calls_made { 0 }
    association :assignee, factory: :user
  end
end
