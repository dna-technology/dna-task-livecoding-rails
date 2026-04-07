Rails.application.routes.draw do
  post "/payments", to: "payments#create", defaults: { format: :json }
  get "/organisers/recent_payments", to: "organisers#recent_payments", defaults: { format: :json }
end
