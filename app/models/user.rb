class User < ApplicationRecord
  belongs_to :merchant
  has_many :payments
  has_one :account

  validates :user_id, presence: true
  validates :full_name, presence: true
  validates :email, presence: true

  def self.create_with_uuid_and_account(attributes)
    merchant_id = attributes.delete(:merchant_id)
    merchant = Merchant.find_by(merchant_id: merchant_id)

    return nil unless merchant
    user = merchant.users.build(attributes)
    user.user_id = SecureRandom.uuid

    user.build_account(balance: 0.0)
    user.account.account_id = SecureRandom.uuid

    user.save!
    user
  end

  def as_json(options = {})
    super(options.merge(except: [ :id, :created_at, :updated_at, :merchant_id ])).merge(merchant_id: merchant.merchant_id)
  end
end
