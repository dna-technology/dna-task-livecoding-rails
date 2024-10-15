class MerchantsController < ApplicationController
  skip_before_action :verify_authenticity_token
  def create
    @merchant = Merchant.create_with_uuid(merchant_params)

    if @merchant
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
