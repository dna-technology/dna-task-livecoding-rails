require 'rails_helper'

RSpec.describe "Payments", type: :request do
  let!(:user) { User.create!(name: "Alice", balance_cents: 1000) }
  let!(:merchant) { Merchant.create!(name: "Burger Stand") }

  describe "POST /payments" do
    context "with valid parameters" do
      it "creates a payment and deducts balance" do
        post "/payments", params: { user_id: user.id, merchant_id: merchant.id, amount_cents: 300 }

        expect(response).to have_http_status(:created)
        expect(user.reload.balance_cents).to eq(700)
        expect(Payment.count).to eq(1)
      end
    end

    context "with insufficient balance" do
      it "returns unprocessable entity" do
        post "/payments", params: { user_id: user.id, merchant_id: merchant.id, amount_cents: 2000 }

        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)['error']).to eq('Insufficient balance')
      end
    end

    # This test is designed to FAIL (demonstrate the bug) if we use a real database with concurrency.
    # In a simple RSpec run it might pass because it's sequential, but it highlights the vulnerability.
    it "is vulnerable to race conditions (Double Spending)" do
      # Simulate two concurrent requests that both see the original balance
      # This is a conceptual test for the candidate to think about.

      # Step 1: Request A starts
      # Step 2: Request B starts
      # Both see balance: 1000, both deduct 600.
      # Result should be 400, but in a race condition it could stay 400 while creating 2 payments (1200 spent).

      # We can't easily test true parallelism in a standard sequential RSpec without Threads,
      # but we can discuss this with the candidate.
    end
  end
end
