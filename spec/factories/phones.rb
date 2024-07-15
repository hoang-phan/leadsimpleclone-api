FactoryBot.define do
  factory :phone do
    association :contact
    value { Faker::PhoneNumber.phone_number }
    kind { "personal" }

    Contact::CONTACT_KINDS.each do |kind|
      trait kind do
        kind { kind }
      end
    end
  end
end
