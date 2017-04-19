Rails.application.routes.draw do
  mount Attachinary::Engine => "/attachinary"
  # get 'organizations/:id', to: "organizations#show"

  # get 'organizations/new', to: "organizations#new"
  # post 'organizations', to: "organizations#create"

  # get 'organizations/:id/edit', to: "organizations#edit"
  # patch 'organizations/:id', to: "organizations#update"

  # delete 'organizations/:id', to: "organizations#destroy"
  resources :organizations
  devise_for :users

  root to: 'pages#home'

  get 'dashboard', to: 'pages#dashboard'


  post "organizations/:id/like", to:"organizations#like"

  match "/organizations/add_new_comment" => "organizations#add_new_comment", :as => "add_new_comment_to_organizations", :via => [:post]
end
