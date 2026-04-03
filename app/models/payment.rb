class Payment < ApplicationRecord
  belongs_to :user
  belongs_to :merchant

  validates :amount_cents, numericality: { greater_than: 0 }
end
