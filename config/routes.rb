Rails.application.routes.draw do
  root 'homes#index'

  devise_for :users, controllers: { sessions: 'my_devise/sessions' }
  resources :users, only: [:show, :update, :edit, :destroy]
  resources :current_locations, only: [:index, :update]
  resources :pings
end
