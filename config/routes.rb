Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }

  resources :users, only: [:show, :index]
  resources :posts
  resources :friendship_requests

  root "posts#new"

end
