Rails.application.routes.draw do
  devise_for :users
  root 'homes#top'

  resources :users,only: [:show,:index,:edit,:update] do
    resource :relationships,only: [:create, :destroy]
    get :followers, on: :member
    get :followeds, on: :member
  end
  resources :books do
    resource :favorites, only: [:create, :destroy]
    resources :book_comments, only: [:create, :destroy]
  end

  get 'home/about' => 'homes#about'
end
