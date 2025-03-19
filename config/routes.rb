Rails.application.routes.draw do
  root 'home#index'

  draw(:admin)

  get 'up' => 'rails/health#show', as: :rails_health_check
  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?
end
