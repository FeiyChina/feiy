Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'registrations' }
  ActiveAdmin.routes(self)
  get 'bookings/create'

  mount Attachinary::Engine => '/attachinary'

  resource :bookings, only: [:create]
  get 'organizations_search', to: 'organizations#search'

  resources :organizations do
    get 'organization_contact', to: 'organizations#organization_contact'
    post 'organization_contact', to: 'organizations#organization_send', as: 'organization_send'
    resources :jobs
    resources :events
  end

  post 'organizations/:id/like', to: 'organizations#like', as: 'like_organization'

  post 'articles/:id/like', to: 'articles#like', as: 'like_article'

  root to: 'pages#home'
  get 'dashboard', to: 'pages#dashboard'
  get 'about_us', to: 'pages#about_us'
  get 'developers', to: 'pages#developers'
  get 'events', to: 'pages#events', as: 'events'
  get 'jobs', to: 'pages#jobs', as: 'jobs'

  get 'articles/search', to: 'articles#search'
  get 'articles/tags/:tag', to: 'articles#by_tag'
  resources 'comments', only: [:create, :destroy]
  resources 'articles', only: [:show, :index]
end
