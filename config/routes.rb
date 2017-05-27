Rails.application.routes.draw do
  get 'sessions/new'

  get 'users/new'

  root 'static_pages#home'
  get  '/help',    to: 'static_pages#help'
  get  '/about',   to: 'static_pages#about'
  get  '/contact', to: 'static_pages#contact'
  get  '/signup' , to: 'users#new'
  #tells server to delete the session / cookie upon logout 
  #otherwise you would remain logged in 
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to:'sessions#destroy'
  resources :users
  # using the resources method on users, allows us to obtain the full REST functions automatically
  # for our temporary sessions however, we need to write get, post, delete routes
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
