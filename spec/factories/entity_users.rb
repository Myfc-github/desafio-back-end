FactoryBot.define do
  factory :entity_user do
    association :entity
    association :user
  end
end
