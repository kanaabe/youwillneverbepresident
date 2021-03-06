Rails.application.routes.draw do
  root 'users#new'
  resources :users, only: [:new, :create, :show, :index, :login]

  get 'auth/facebook', as: "auth_provider"
  get 'auth/facebook/callback', to: 'users#login'
  get 'logout', to: 'users#logout'

  get 'results', to:'users#results', as:"results"
  get 'beta', to: 'social_graveyards#index'
  get 'beta_results', to: 'social_graveyards#results'
end
