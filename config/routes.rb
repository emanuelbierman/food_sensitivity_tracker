Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "sessions#new"
  post "/signin", to: "sessions#create"
  post "/signup", to: "users#create"
  get "/signout", to: "sessions#destroy"
  resources :users do
    resources :days_foods, only: [:create]
    resources :days_symptoms, only: [:create]
    resources :days, only: [:index]
    resources :foods, only: [:index, :show, :destroy]
    resources :symptoms, only: [:index, :show, :destroy]
  end


  # only admins can delete foods and symptoms
  # namespace admin do
  #   get "delete", to: "foods#delete"
  #   get "delete", to: "symptoms#delete"
  # end
end
