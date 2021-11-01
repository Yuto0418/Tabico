Rails.application.routes.draw do
  get 'tweets/index'
  devise_for :users
  root 'users#index'
  resources :users
    # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
