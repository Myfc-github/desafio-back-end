class Account < ApplicationRecord
  has_many :entities

  validates :name, presence: true
end
