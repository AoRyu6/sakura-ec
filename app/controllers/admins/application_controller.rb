class Admins::ApplicationController < ActionController::Base
  include Pagy::Backend

  allow_browser versions: :modern unless Rails.env.development?

  before_action :authenticate_admin!
  layout 'admin/application'

  unless Rails.env.production?
    around_action :n_plus_one_detection

    def n_plus_one_detection
      Prosopite.scan
      yield
    ensure
      Prosopite.finish
    end
  end
end
