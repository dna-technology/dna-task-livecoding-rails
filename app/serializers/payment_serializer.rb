class PaymentSerializer
  def initialize(payment)
    @payment = payment
  end

  def as_json(*)
    {
      payment_id: @payment.payment_id,
      amount: @payment.amount,
      user_id: @payment.user.user_id,
      merchant_id: @payment.merchant.merchant_id
    }
  end
end
