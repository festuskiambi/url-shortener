Rails.application.routes.draw do
  resources :urls
  post 'auth/login', to: 'authentication#authenticate'
  post 'signup', to: 'users#create'
end
