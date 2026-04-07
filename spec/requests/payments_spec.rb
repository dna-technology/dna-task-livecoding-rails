require 'rails_helper'

RSpec.describe "Payments", type: :request do
  let!(:user) { User.create!(full_name: "Alice", email: "alice@test.com") }
  let!(:merchant) { Merchant.create!(name: "Burger Stand") }

  before do
    user.account.update!(balance: 1000.0)
  end

  describe "POST /payments" do
    context "with valid parameters" do
      it "creates a payment and deducts balance" do
        post "/payments", params: { user_id: user.id, merchant_id: merchant.id, amount: 300.0 }

        expect(response).to have_http_status(:created)
        expect(user.account.reload.balance).to be_within(0.001).of(700.0)
        expect(Payment.count).to eq(1)
      end
    end

    context "with insufficient balance" do
      it "returns unprocessable entity" do
        post "/payments", params: { user_id: user.id, merchant_id: merchant.id, amount: 2000.0 }

        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)['error']).to eq('Insufficient balance')
      end
    end
  end
end
