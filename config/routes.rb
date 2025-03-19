Rails.application.routes.draw do
  draw(:admin)

  get 'up' => 'rails/health#show', as: :rails_health_check
end
