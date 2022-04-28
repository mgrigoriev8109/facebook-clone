Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }

  resources :users, only: [:show, :index]
  resources :posts

  root "posts#new"

end
