class Entity < ApplicationRecord
  belongs_to :account
  has_many :entity_user
end
