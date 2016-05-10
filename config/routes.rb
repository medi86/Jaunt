Rails.application.routes.draw do
   root  'jaunt#home'
   get  '/index',       to: 'jaunt#index', as: "jaunts"
   post '/', to: 'jaunt#create', as: "create_jaunt"
   get  '/new',    to: 'jaunt#new', as: 'new_jaunt'
end

