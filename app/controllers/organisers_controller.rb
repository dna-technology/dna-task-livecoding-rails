class OrganisersController < ApplicationController
  # INTERVIEWER NOTE (Bug 2 - Performance N+1):
  # ------------------------------------------
  # The Jbuilder view (index.json.jbuilder) will trigger N+1 queries
  # because the controller does not use .includes(:user, :merchant).
  #
  # EXPECTATION:
  # ------------
  # Use `Payment.includes(:user, :merchant).limit(50)` here.
  
  def recent_payments
    @payments = Payment.order(created_at: :desc).limit(50)
    # Renders app/views/organisers/recent_payments.json.jbuilder
  end
end
