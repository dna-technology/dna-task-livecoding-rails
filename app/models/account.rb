class Account < ApplicationRecord
  belongs_to :user

  # INTERVIEWER NOTE (Bug 3 - Float Precision):
  # Using float for comparison is dangerous. 
  # 50.0 - 14.7 - 14.7 - 14.7 results in 5.899999999999999, 
  # making 'balance >= 5.9' evaluate to false.
  def has_funds?(amount)
    balance >= amount
  end
end
