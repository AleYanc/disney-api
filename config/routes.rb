Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  namespace :api do
    namespace :v1 do

      # Basic routes
      resources :users
      resources :studios
      resources :genres
      resources :productions
      resources :characters

      #Auth routes
      post "auth", to: "auth#create", as: "auth"
    end
  end
end
