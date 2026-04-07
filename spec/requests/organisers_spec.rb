require 'rails_helper'

RSpec.describe "Organisers", type: :request do
  let!(:user) { User.create!(full_name: "Alice", email: "alice@test.com") }
  let!(:merchant) { Merchant.create!(name: "Burger Stand") }

  before do
    5.times do
      Payment.create!(user: user, merchant: merchant, amount: 10.0)
    end
  end

  describe "GET /organisers/recent_payments" do
    it "returns the list of payments with user and merchant names" do
      get "/organisers/recent_payments"

      expect(response).to have_http_status(:ok)

      json = JSON.parse(response.body)
      expect(json.size).to eq(5)
      expect(json.first).to have_key('user_name')
      expect(json.first).to have_key('merchant_name')
    end
  end
end
