Rails.application.routes.draw do
  get 'sessions/new'

   root 'jaunt#home'
   get  '/index',     to: 'jaunt#index',  as: "jaunts"
   post '/jaunts',    to: 'jaunt#create', as: "create_jaunt"
   get  '/new',       to: 'jaunt#new',    as: 'new_jaunt'
   get  '/show/:id',  to: 'jaunt#show',   as: 'show_jaunt'

   get    'signup'  => 'users#new'
   get    'login'   => 'sessions#new'
   post   'login'   => 'sessions#create'
   delete 'logout'  => 'sessions#destroy'

   resources :users
end

