# Seed some initial data for the Festival Payment API
User.destroy_all
Merchant.destroy_all
Payment.destroy_all

alice = User.create!(name: "Alice", balance_cents: 10000) # $100
bob = User.create!(name: "Bob", balance_cents: 5000)      # $50

burger_stand = Merchant.create!(name: "Burger Stand")
drink_shack = Merchant.create!(name: "Drink Shack")

# Create some historical payments
Payment.create!(user: alice, merchant: burger_stand, amount_cents: 1500, created_at: 2.days.ago)
Payment.create!(user: bob, merchant: drink_shack, amount_cents: 800, created_at: 1.day.ago)
Payment.create!(user: alice, merchant: drink_shack, amount_cents: 1200, created_at: 5.hours.ago)

puts "Seeding completed: #{User.count} users, #{Merchant.count} merchants, #{Payment.count} payments."
