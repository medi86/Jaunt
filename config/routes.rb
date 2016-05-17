Rails.application.routes.draw do
   get 'sessions/new'

   root 'jaunt#home'
   get  '/index',     to: 'jaunt#index',  as: "jaunts"
   get  '/edit/:id',  to: 'jaunt#edit',   as: "edit_jaunt"
   post '/jaunts',    to: 'jaunt#create', as: "create_jaunt"
   get  '/new',       to: 'jaunt#new',    as: 'new_jaunt'
   get  '/show/:id',  to: 'jaunt#show',   as: 'show_jaunt'
   delete '/show/:id',   to: 'jaunt#destroy', as: 'delete_jaunt'

   post '/search', to: 'jaunt#search'

   get    'signup'  => 'users#new'
   get    'login'   => 'sessions#new'
   post   'login'   => 'sessions#create'
   delete 'logout'  => 'sessions#destroy'

   resources :users
   resources :jaunts
end

