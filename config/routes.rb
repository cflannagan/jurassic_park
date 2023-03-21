Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :cages, defaults: {format: :json}
  resources :dinosaurs, defaults: {format: :json}
  resources :species, defaults: {format: :json}
end
