puts "Seeding merchants..."

food_stall  = Merchant.find_by(name: "Food & Drinks") || Merchant.create!(name: "Food & Drinks")
merch_stall = Merchant.find_by(name: "Merchandise")   || Merchant.create!(name: "Merchandise")
bar         = Merchant.find_by(name: "Bar")           || Merchant.create!(name: "Bar")

puts "Seeding users..."

alice = User.find_by(email: "alice@festival.com")
unless alice
  alice = User.create_with_uuid_and_account({ full_name: "Alice Johnson", email: "alice@festival.com", merchant_id: food_stall.merchant_id })
  alice.account.update!(balance: 100.0)
end

bob = User.find_by(email: "bob@festival.com")
unless bob
  bob = User.create_with_uuid_and_account({ full_name: "Bob Smith", email: "bob@festival.com", merchant_id: food_stall.merchant_id })
  bob.account.update!(balance: 25.0)
end

carol = User.find_by(email: "carol@festival.com")
unless carol
  carol = User.create_with_uuid_and_account({ full_name: "Carol White", email: "carol@festival.com", merchant_id: merch_stall.merchant_id })
  carol.account.update!(balance: 5.0)
end

puts "Seeding payments..."

# Alice spends throughout the day — 30.0 + 20.0 = 50.0 spent, 50.0 remaining
unless alice.payments.exists?
  Payment.create_with_uuid({ amount: 30.0, user_id: alice.user_id, merchant_id: food_stall.merchant_id })
  Payment.create_with_uuid({ amount: 20.0, user_id: alice.user_id, merchant_id: merch_stall.merchant_id })
end

# Bob spends across stalls — 10.0 + 10.0 + 5.0 = 25.0 spent, 0.0 remaining
unless bob.payments.exists?
  Payment.create_with_uuid({ amount: 10.0, user_id: bob.user_id, merchant_id: merch_stall.merchant_id })
  Payment.create_with_uuid({ amount: 10.0, user_id: bob.user_id, merchant_id: food_stall.merchant_id })
  Payment.create_with_uuid({ amount: 5.0,  user_id: bob.user_id, merchant_id: bar.merchant_id })
end

# Carol spends on food — 2.0 + 2.0 = 4.0 spent, 1.0 remaining
unless carol.payments.exists?
  Payment.create_with_uuid({ amount: 2.0, user_id: carol.user_id, merchant_id: food_stall.merchant_id })
  Payment.create_with_uuid({ amount: 2.0, user_id: carol.user_id, merchant_id: bar.merchant_id })
end

puts ""
puts "Done!"
puts "  Merchants : #{Merchant.count}"
puts "  Users     : #{User.count}"
puts "  Payments  : #{Payment.count}"
puts ""
puts "Account balances:"
User.includes(:account).each { |u| puts "  #{u.full_name}: #{u.account.balance}" }
