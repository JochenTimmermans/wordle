Rails.application.routes.draw do
  get '/', to: 'game#index', as: 'index'
  get '/play', to: 'game#new_game', as: 'new_game'
  get '/play/:uuid', to: 'game#play', as: 'play'
  post '/play/:uuid', to: 'game#guess', as: 'guess'

  root "game#index"
end
