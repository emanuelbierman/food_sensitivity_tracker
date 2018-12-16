Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # root "users#show"
  # get "signup", to: "users#new"
  root to: "sessions#new"
  post "/sessions/create", to: "sessions#create"
  post "/signout", to: "sessions#destroy"
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
