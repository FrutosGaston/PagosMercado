Rails.application.routes.draw do
  resources :users
  resources :payments, only: :create
  resources :payment_intention, only: :create
end
