class Account < ApplicationRecord
  belongs_to :user

  def has_funds?(amount)
    balance >= amount
  end
end
