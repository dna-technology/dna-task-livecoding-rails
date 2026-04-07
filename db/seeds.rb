Payment.destroy_all
Account.destroy_all
User.destroy_all
Merchant.destroy_all

puts "Seeding merchants..."

food_stall  = Merchant.create!(name: "Food & Drinks")
merch_stall = Merchant.create!(name: "Merchandise")
bar         = Merchant.create!(name: "Bar")

puts "Seeding users..."

alice = User.create!(full_name: "Alice Johnson", email: "alice@festival.com")
alice.account.update!(balance: 100.0)

bob = User.create!(full_name: "Bob Smith", email: "bob@festival.com")
bob.account.update!(balance: 25.0)

carol = User.create!(full_name: "Carol White", email: "carol@festival.com")
carol.account.update!(balance: 5.0)

puts "Seeding payments..."

# Alice spends throughout the day — 30.0 + 20.0 = 50.0 spent, 50.0 remaining
[ 30.0, 20.0 ].each_with_index do |amount, i|
  merchant = i == 0 ? food_stall : merch_stall
  alice.account.balance -= amount
  alice.account.save!
  Payment.create!(user: alice, merchant: merchant, amount: amount)
end

# Bob spends across stalls — 10.0 + 10.0 + 5.0 = 25.0 spent, 0.0 remaining
[
  [ 10.0, merch_stall ],
  [ 10.0, food_stall ],
  [ 5.0, bar ]
].each do |amount, merchant|
  bob.account.balance -= amount
  bob.account.save!
  Payment.create!(user: bob, merchant: merchant, amount: amount)
end

# Carol spends on food — 2.0 + 2.0 = 4.0 spent, 1.0 remaining
2.times do
  amount = 2.0
  merchant = [ food_stall, bar ].sample
  carol.account.balance -= amount
  carol.account.save!
  Payment.create!(user: carol, merchant: merchant, amount: amount)
end

puts ""
puts "Done!"
puts "  Merchants : #{Merchant.count}"
puts "  Users     : #{User.count}"
puts "  Payments  : #{Payment.count}"
puts ""
puts "Account balances:"
User.includes(:account).each { |u| puts "  #{u.full_name}: #{u.account.balance}" }
