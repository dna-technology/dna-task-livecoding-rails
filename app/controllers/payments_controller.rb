class PaymentsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    begin
      @payment = Payment.create_with_uuid(payment_params)
    rescue InsufficientFundsError
      render json: {
        error: "User has insufficient funds"
      }, status: :bad_request
    else
      if @payment
        render json: @payment.as_json
      else
        head :unprocessable_entity
      end
    end
  end

  private

  def payment_params
    params.permit(:amount, :userId, :merchantId)
  end
end
