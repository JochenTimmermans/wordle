Rails.application.routes.draw do
  get 'game/index', as: 'index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "game#index"
end
