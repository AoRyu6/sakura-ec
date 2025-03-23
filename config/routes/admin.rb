devise_for :admins, skip: %i[confirmations],
                    controllers: { sessions: 'admins/sessions',
                                   passwords: 'admins/passwords' }

namespace :admins do
  root 'home#index'
  resources :products do
    resource :position, only: :update, module: :products
  end
end
