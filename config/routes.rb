Rails.application.routes.draw do
  get 'organizations/new', to: "organization#new"

  post 'organizations/create', to: "organization#create"

  get 'organizations/edit'

  get 'organizations/update'

  get 'organizations/destroy'

  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'pages#home'

end
