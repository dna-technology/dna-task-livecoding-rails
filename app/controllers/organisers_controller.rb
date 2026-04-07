class OrganisersController < ApplicationController
  def recent_payments
    @payments = Payment.order(created_at: :desc).limit(50)
    # Renders app/views/organisers/recent_payments.json.jbuilder
  end
end
