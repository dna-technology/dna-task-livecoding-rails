class PaymentsController < ApplicationController
  def create
    user = User.find(params[:user_id])
    merchant = Merchant.find(params[:merchant_id])
    amount = params[:amount].to_f

    if user.account.balance >= amount
      user.account.balance -= amount
      user.account.save!

      payment = Payment.create!(
        user: user,
        merchant: merchant,
        amount: amount
      )

      render json: payment, status: :created
    else
      render json: { error: "Insufficient balance" }, status: :unprocessable_entity
    end
  rescue ActiveRecord::RecordNotFound => e
    render json: { error: e.message }, status: :not_found
  rescue StandardError => e
    render json: { error: e.message }, status: :internal_server_error
  end
end
