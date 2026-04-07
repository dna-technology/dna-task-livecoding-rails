json.array! @payments do |payment|
  json.id payment.id
  json.amount payment.amount
  json.created_at payment.created_at
  json.user_name payment.user.full_name   # INTERVIEWER NOTE: N+1 Triggers here
  json.merchant_name payment.merchant.name # INTERVIEWER NOTE: N+1 Triggers here
end
