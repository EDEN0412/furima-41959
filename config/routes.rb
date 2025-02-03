Rails.application.routes.draw do
  devise_for :users
  root to: 'items#index'
  resources :items do
    resources :items, only: [:index, :new, :create, :show, :edit, :update]
  end
end
