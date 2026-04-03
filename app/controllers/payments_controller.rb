class PaymentsController < ApplicationController
  # INTERVIEWER NOTE (Bug 1 - Race Condition & Data Integrity):
  # -----------------------------------------------------------
  # The logic below is prone to double-spending. Because there is no
  # Database Transaction and no Pessimistic Locking (with_lock),
  # two concurrent requests can read the same balance and proceed.
  #
  # REFACTORING EXPECTATION (The Rails Way):
  # ----------------------------------------
  # 1. Logic should be moved to the Model (e.g., User#pay! or Payment.process!).
  # 2. Wrap the balance deduction and payment creation in a Transaction.
  # 3. Use `user.with_lock` to ensure the balance isn't modified mid-read.

  def create
    user = User.find(params[:user_id])
    merchant = Merchant.find(params[:merchant_id])
    amount = params[:amount_cents].to_i

    # DANGER: Checking and updating balance without an atomic operation or lock.
    if user.balance_cents >= amount
      user.balance_cents -= amount
      user.save! # This change is committed before the Payment is even created.

      payment = Payment.create!(
        user: user,
        merchant: merchant,
        amount_cents: amount
      )

      render json: payment, status: :created
    else
      render json: { error: 'Insufficient balance' }, status: :unprocessable_entity
    end
  rescue ActiveRecord::RecordNotFound => e
    render json: { error: e.message }, status: :not_found
  rescue StandardError => e
    render json: { error: e.message }, status: :internal_server_error
  end
end
