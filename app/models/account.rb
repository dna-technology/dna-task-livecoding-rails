class Account < ApplicationRecord
  belongs_to :user

  validates :accountId, presence: true
  validates :balance, presence: true
end
