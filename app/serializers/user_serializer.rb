class UserSerializer
  def initialize(user)
    @user = user
  end

  def as_json(*)
    {
      user_id: @user.user_id,
      full_name: @user.full_name,
      email: @user.email,
      merchant_id: @user.merchant.merchant_id
    }
  end
end
