Rails.application.routes.draw do
  get 'bookings/create'

  mount Attachinary::Engine => "/attachinary"
  # get 'organizations/:id', to: "organizations#show"

  # get 'organizations/new', to: "organizations#new"
  # post 'organizations', to: "organizations#create"

  # get 'organizations/:id/edit', to: "organizations#edit"
  # patch 'organizations/:id', to: "organizations#update"

  # delete 'organizations/:id', to: "organizations#destroy"
  resource :bookings, only: [:create]

  resources :organizations do
    resources :jobs
  end

  post "organizations/:id/like", to:"organizations#like", as: "like_organization"
  devise_for :users

  get 'organization_contact', to: 'pages#organization_contact'

  root to: 'pages#home'
  get 'dashboard', to: 'pages#dashboard'
  get 'eventshow', to: 'pages#eventshow', as: "event_show"
  get 'jobspool', to: 'pages#jobspool', as: "jobspool"
  get 'organizations/search', to: 'organizations#search', as: "organizations_search"
  post 'comments' => 'comments#create', as: "create_comment"

end
