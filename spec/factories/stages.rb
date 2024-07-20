FactoryBot.define do
  factory :stage do
    sequence(:name) { |i| "Stage #{i}" }
    color { Faker::Color.hex_color }
    kind { :lead }
  end
end
