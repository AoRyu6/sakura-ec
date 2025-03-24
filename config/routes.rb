Rails.application.routes.draw do
  root 'products#index'

  devise_for :users, controllers: { registrations: 'users/registrations' }
  draw(:admin)

  resources :products, only: :show
  resources :diaries
  resource :cart, only: :show do
    resources :cart_items, only: %i[create destroy]
  end
  resources :orders, only: :create

  get 'up' => 'rails/health#show', as: :rails_health_check
  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?
end
