FactoryBot.define do
  factory :contact do
    association :source
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    company_name { Faker::Company.name }
  end
end
