FactoryBot.define do
  factory :account do
    name { Faker::Space.galaxy }
    entities { build_list :entity, 1 }
  end
end
