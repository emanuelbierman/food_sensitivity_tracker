Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "days#index"
  # get "signup", to: "users#new"
  get "/signin", to: "sessions#new"
  get "/sessions/create", to: "sessions#create"
  get "/signout", to: "sessions#logout"
  get "/profile", to: "users#show"
  resources :users do
    resources :days, only: [:index, :show, :edit, :create]
    resources :food, only: [:index, :new, :create, :show]
    resources :symptoms, only: [:index, :new, :create, :show]
  end

  # only admins can delete foods and symptoms
  # namespace admin do
  #   get "delete", to: "foods#delete"
  #   get "delete", to: "symptoms#delete"
  # end
end
