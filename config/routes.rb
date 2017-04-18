Rails.application.routes.draw do

  get 'organizations/:id', to: "organizations#show"

  get 'organizations/new', to: "organizations#new"
  post 'organizations', to: "organizations#create"

  get 'organizations/:id/edit', to: "organizations#edit"
  patch 'organizations/:id', to: "organizations#update"

  delete 'organizations/:id', to: "organizations#destroy"

  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'pages#home'

  get 'dashboard', to: 'pages#dashboard'

end
