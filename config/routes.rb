Rails.application.routes.draw do
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
  devise_for :users
  root to: 'books#index'
  resources :books do
    scope module: :books do
      resources :comments, only: %i[create]
    end
  end
  resources :users, only: %i[index show] do
    resource :relationships, only: %i[create destroy]
    scope module: :users do
      resources :followings, only: [:index]
      resources :followers, only: [:index]
    end
    resources :reports, only: %i[index] do
      scope module: :reports do
        resources :comments, only: %i[create]
      end
    end
  end
  resources :reports, only: %i[new show create edit update destroy]
end
