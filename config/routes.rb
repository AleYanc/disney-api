Rails.application.routes.draw do
  resources :users
  resources :studios
  resources :genres
  resources :productions
  resources :characters
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
