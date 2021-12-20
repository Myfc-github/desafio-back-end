class Entity < ApplicationRecord
  has_and_belongs_to_many :users
  belongs_to :account

  validates :name, presence: true
end
