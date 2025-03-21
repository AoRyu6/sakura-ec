# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create] # rubocop:disable Rails/LexicallyScopedActionFilter
  before_action :configure_account_update_params, only: [:update] # rubocop:disable Rails/LexicallyScopedActionFilter

  protected

  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end

  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: [:name])
  end
end
