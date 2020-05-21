Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :users, only: [:create, :new, :show, :index]

  resource :session, only: [:new, :create, :destroy]

  resources :tasks

  resources :comments, only: [:create]

  root to: redirect('/session/new')
end
