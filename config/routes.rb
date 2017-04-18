Rails.application.routes.draw do

  # get 'organizations/:id', to: "organizations#show"

  # get 'organizations/new', to: "organizations#new"
  # post 'organizations', to: "organizations#create"

  # get 'organizations/:id/edit', to: "organizations#edit"
  # patch 'organizations/:id', to: "organizations#update"

  # delete 'organizations/:id', to: "organizations#destroy"
  resources :organizations
  devise_for :users

  root to: 'pages#home'

end
