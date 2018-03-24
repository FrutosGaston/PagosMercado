Rails.application.routes.draw do

  post '/users', to: 'users#create'
  get '/users', to: 'users#balance'

  post '/start-payment', to: 'payments#start'
  post '/credit-payment', to: 'payments#credit'

end
