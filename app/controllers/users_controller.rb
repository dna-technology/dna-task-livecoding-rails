class UsersController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    @user = User.create_with_uuid_and_account(user_params)

    if @user
      render json: @user.as_json
    else
      head :unprocessable_entity
    end
  end

  private

  def user_params
    params.permit(:fullName, :email, :merchantId)
  end
end
