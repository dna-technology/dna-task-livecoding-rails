class Account < ApplicationRecord
  belongs_to :user
  
  # CRITICAL BUG: Floating point comparison
  def has_funds?(amount)
    balance >= amount
  end
end
