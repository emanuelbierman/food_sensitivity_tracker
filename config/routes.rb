Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # root "users#show"
  # get "signup", to: "users#new"
  root to: "sessions#new"
  post "/sessions/create", to: "sessions#create"
  get "/signout", to: "sessions#destroy"
  resources :users do
    resources :days_foods, only: [:create, :update]
    resources :days_symptoms, only: [:create, :update]
    resources :days, only: [:index, :update]
    resources :foods, only: [:index, :show, :destroy]
    resources :symptoms, only: [:show, :destroy]
  end

  # only admins can delete foods and symptoms
  # namespace admin do
  #   get "delete", to: "foods#delete"
  #   get "delete", to: "symptoms#delete"
  # end
end
