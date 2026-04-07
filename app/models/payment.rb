class Payment < ApplicationRecord
  belongs_to :user
  belongs_to :merchant

  validates :amount, numericality: { greater_than: 0 }
end
