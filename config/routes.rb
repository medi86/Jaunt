Rails.application.routes.draw do
   get 'sessions/new'

   root   'jaunt#home'
   get    '/edit/:id',  to: 'jaunt#edit',    as: "edit_jaunt"
   match  '/jaunts',    to: 'jaunt#create',  as: "create_jaunt", via: [:get, :post]
   get    '/new',       to: 'jaunt#new',     as: 'new_jaunt'
   get    '/show/:id',  to: 'jaunt#show',    as: 'show_jaunt'
   delete '/show/:id',  to: 'jaunt#destroy', as: 'delete_jaunt'

   post   '/search',    to: 'jaunt#search',  as: 'search'
   get    '/search',    to: 'jaunt#index'

   get    'signup'  => 'users#new'
   get    'login'   => 'sessions#new'
   get    'new_session'     => 'sessions#new'
   post   'login'   => 'sessions#create'
   get    'logout'  => 'sessions#destroy'
   delete 'logout'  => 'sessions#destroy'

   devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

   resources :users
end

