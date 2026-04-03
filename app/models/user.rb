class User < ApplicationRecord
  has_many :payments
  validates :name, presence: true
  validates :balance_cents, numericality: { greater_than_or_equal_to: 0 }
end
