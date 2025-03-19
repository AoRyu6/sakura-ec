# frozen_string_literal: true

class Admins::PasswordsController < Devise::PasswordsController
  protected

  def after_resetting_password_path_for(resource)
    admins_root_path
  end
end
