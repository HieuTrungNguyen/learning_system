Rails.application.routes.draw do

  root "static_pages#home"
  get "home", to: "static_pages#home"
  get "help", to: "static_pages#help"
  get "contact", to: "static_pages#contact"
  get "about", to: "static_pages#about"
  get "signup", to: "users#new"
  post "signup", to: "users#create"
  get "login", to: "sessions#new"
  post "login", to: "sessions#create"
  delete "logout", to: "sessions#destroy"

  resources :users
  resources :categories, only: [:index, :show]
  resources :csv, only: [:index, :create]
  resources :lessons

  namespace :admin do
    resources :categories
    resources :users, except: [:edit, :update]
    resources :words
  end
end
