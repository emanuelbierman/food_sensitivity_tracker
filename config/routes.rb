Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "days#index"
  get "signup", to: "users#new"
  resources :users do
    resources :days, only: [:index, :show, :edit, :create]
  end
  resources :food
  resources :symptoms

  # only admins can delete foods and symptoms
  # namespace admin do
  #   get "delete", to: "foods#delete"
  #   get "delete", to: "symptoms#delete"
  # end
end
