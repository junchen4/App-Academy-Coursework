Rails.application.routes.draw do
  resources :users, only: [:create, :new, :show] do
    resources :comments, only: [:create]
  end
  resources :goals do
    resources :comments, only: [:create]
  end
  resource :session, only: [:new, :create, :destroy]
  resources :comments, only: :destroy
end
