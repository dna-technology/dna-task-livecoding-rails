class User < ApplicationRecord
  has_one :account, dependent: :destroy
  has_many :payments
  validates :full_name, :email, presence: true

  after_create :ensure_account

  private

  def ensure_account
    create_account(balance: 0.0) unless account
  end
end
