class Payment < ApplicationRecord
  belongs_to :user
  belongs_to :merchant

  validates :paymentId, presence: true
  validates :amount, presence: true

  def self.create_with_uuid(attributes)
    payment = nil
    Payment.transaction do
      merchantId = attributes.delete(:merchantId)
      merchant = Merchant.find_by(merchantId: merchantId)

      userId = attributes.delete(:userId)
      user = User.find_by(userId: userId)

      return nil unless merchant
      return nil unless user

      account = user.account
      return nil unless account

      amount = attributes[:amount].to_f
      raise InsufficientFundsError unless account.balance >= amount
      account.balance -= amount
      account.save!

      payment = merchant.payments.build(attributes.merge(user_id: user.id))
      payment.paymentId = SecureRandom.uuid

      payment.save!
    end
    payment
  end

  def as_json(options = {})
    super(options.merge(except: [ :id, :created_at, :updated_at, :merchant_id ])).merge(merchantId: merchant.merchantId, userId: user.userId)
  end
end
