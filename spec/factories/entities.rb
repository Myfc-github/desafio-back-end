FactoryBot.define do
  factory :entity do
    name { Faker::Company.name }
    users { build_list :user, 1 }
  end
end
