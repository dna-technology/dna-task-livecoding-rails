require 'rails_helper'

RSpec.describe "Architecture Check", type: :request do
  describe "PaymentsController architecture" do
    it "directly handles payment logic (God Controller)" do
      # This test exists solely to highlight the need for a service object
      # or a more modular approach.
      expect(File.read('app/controllers/payments_controller.rb')).to include('user.balance_cents -= amount')
      expect(File.read('app/controllers/payments_controller.rb')).to include('Payment.create!')
    end
  end
end
