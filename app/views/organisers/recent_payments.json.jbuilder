json.array! @payments do |payment|
  json.id payment.id
  json.amount payment.amount
  json.created_at payment.created_at
  json.user_name payment.user.full_name
  json.merchant_name payment.merchant.name
end
