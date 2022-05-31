class Account < ApplicationRecord
  has_many :entities, dependent: :destroy
  validates :name, presence: true
end
