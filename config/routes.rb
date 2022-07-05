Rails.application.routes.draw do
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
  devise_for :users
  root to: 'books#index'
  resources :books
  resources :users, only: %i(index show) do
    resources :following, only: [:index], controller: 'users/followings'
    resources :followers, only: [:index], controller: 'users/followers'
  end

  resources :follows, only: [:create, :destroy]
end
