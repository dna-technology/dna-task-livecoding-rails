class User < ApplicationRecord
  belongs_to :merchant
  has_many :payments
  has_one :account

  validates :userId, presence: true
  validates :fullName, presence: true
  validates :email, presence: true

  def self.create_with_uuid_and_account(attributes)
    merchantId = attributes.delete(:merchantId)
    merchant = Merchant.find_by(merchantId: merchantId)

    return nil unless merchant
    user = merchant.users.build(attributes)
    user.userId = SecureRandom.uuid

    user.build_account(balance: 0.0)
    user.account.accountId = SecureRandom.uuid

    user.save!
    user
  end

  def as_json(options = {})
    super(options.merge(except: [ :id, :created_at, :updated_at, :merchant_id ])).merge(merchantId: merchant.merchantId)
  end
end
