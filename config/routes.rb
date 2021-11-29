Rails.application.routes.draw do
  get 'tweets/index'
  devise_for :users
  root 'users#index'
  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
  end
  resources :users, except: :create do
    member do
      get :followings, :followers
    end
    collection do
      get 'search'
    end
  end
  resources :tweets do
    resources :comments, only: [:create, :destroy]
    collection do
      get 'search'
    end
  end
  resources :relationships, only: [:create, :destroy]
  resources :messages, only: [:create]
  resources :rooms, only: [:index,:create,:show]
    # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
