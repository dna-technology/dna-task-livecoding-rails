class User < ApplicationRecord
  belongs_to :merchant
  has_many :payments
  has_one :account

  validates :user_id, presence: true
  validates :full_name, presence: true
  validates :email, presence: true

  def self.create_with_uuid_and_account(attributes)
    merchant = Merchant.find_by(merchant_id: attributes.delete(:merchant_id))
    return nil unless merchant

    user = merchant.users.build(attributes.merge(user_id: SecureRandom.uuid))
    user.build_account(account_id: SecureRandom.uuid, balance: 0.0)
    user.save!
    user
  end

end
