FactoryBot.define do
  factory :entity do
    name { Faker::Company.name }
    association :account
  end
end
