FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { SecureRandom.uuid }

    after(:build) do |user|
      user.password_confirmation = user.password
    end
  end
end
