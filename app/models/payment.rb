class Payment < ApplicationRecord
  belongs_to :user
  belongs_to :merchant

  validates :payment_id, presence: true
  validates :amount, presence: true

  def self.create_with_uuid(attributes)
    payment = nil
    merchant_id = attributes.delete(:merchant_id)
    merchant = Merchant.find_by(merchant_id: merchant_id)

    user_id = attributes.delete(:user_id)
    user = User.find_by(user_id: user_id)

    return nil unless merchant
    return nil unless user

    account = user.account
    return nil unless account

    amount = attributes[:amount].to_f
    raise InsufficientFundsError unless account.balance >= amount
    account.balance -= amount
    account.save!

    payment = merchant.payments.build(attributes.merge(user_id: user.id))
    payment.payment_id = SecureRandom.uuid

    payment.save!
    payment
  end

  def as_json(options = {})
    super(options.merge(except: [ :id, :created_at, :updated_at, :merchant_id ])).merge(merchant_id: merchant.merchant_id, user_id: user.user_id)
  end
end
