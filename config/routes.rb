Rails.application.routes.draw do
  post "/payments", to: "payments#create"
  get "/organisers/recent_payments", to: "organisers#recent_payments"
end
