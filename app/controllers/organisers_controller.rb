class OrganisersController < ApplicationController
  # INTERVIEWER NOTE (Bug 2 - Performance N+1):
  # ------------------------------------------
  # Accessing `payment.user.name` and `payment.merchant.name` in a loop
  # without `.includes(:user, :merchant)` triggers 2 additional queries per payment.
  #
  # EXPECTATION:
  # ------------
  # Use `Payment.includes(:user, :merchant).limit(50)` to fetch data in 3 queries total.

  def recent_payments
    payments = Payment.order(created_at: :desc).limit(50)

    payment_data = payments.map do |payment|
      {
        id: payment.id,
        amount_cents: payment.amount_cents,
        created_at: payment.created_at,
        user_name: payment.user.name,      # Triggers N+1
        merchant_name: payment.merchant.name # Triggers N+1
      }
    end

    render json: payment_data
  end
end
