Rails.application.routes.draw do
  namespace :tabico do
    resources :users,            only: [:index]
  end
    # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
