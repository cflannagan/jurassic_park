Rails.application.routes.draw do
  resources :cages, defaults: {format: :json}
  resources :dinosaurs, defaults: {format: :json}
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
