Rails.application.routes.draw do
  root 'welcome#index'

  get '/register', to: 'users#new'
  post '/users', to: 'users#create'
  get '/login', to: 'users#login_form'
  post '/login', to: 'users#login_user'
  get '/logout', to: 'users#logout'
  get '/movies', to: 'movies#index'
  get '/movies/:id', to: 'movies#show', as: 'movie'
  get '/dashboard', to: 'users#show'

  get '/movies/:movie_id/viewing_parties/new', to: 'viewing_parties#new'
  post '/movies/:movie_id/viewing_parties', to: 'viewing_parties#create'

  namespace :admin do
    get '/dashboard', to: 'dashboard#index'
  end
end
