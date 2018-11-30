Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "days#index"
  get "signup", to "users#new"
  resources :users do
    resources :days
    resources :food
    resources :symptoms
  end
end
