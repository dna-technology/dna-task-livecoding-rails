class Account < ApplicationRecord
  belongs_to :user

  validates :account_id, presence: true
  validates :balance, presence: true
end
