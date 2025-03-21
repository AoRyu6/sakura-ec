Rails.application.routes.draw do
  root 'products#index'
  resources :products, only: :show

  draw(:admin)

  get 'up' => 'rails/health#show', as: :rails_health_check
  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?
end
