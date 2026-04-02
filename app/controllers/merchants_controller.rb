class MerchantsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    @merchant = Merchant.new(merchant_params)

    if @merchant.save
      render json: @merchant.as_json
    else
      head :unprocessable_entity
    end
  end

  private

  def merchant_params
    params.permit(:name)
  end
end
