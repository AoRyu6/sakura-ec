class Admins::ApplicationController < ActionController::Base
  allow_browser versions: :modern unless Rails.env.development?

  before_action :authenticate_admin!
  layout 'admin/application'
end
