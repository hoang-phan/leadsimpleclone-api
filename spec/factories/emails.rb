FactoryBot.define do
  factory :email do
    association :contact
    value { Faker::Internet.email }
    kind { "personal" }

    Contact::CONTACT_KINDS.each do |kind|
      trait kind do
        kind { kind }
      end
    end
  end
end
