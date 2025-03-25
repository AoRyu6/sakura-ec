class ApplicationController < ActionController::Base
  include Pagy::Backend

  allow_browser versions: :modern

  before_action :authenticate_user!

  def current_cart
    if user_signed_in?
      current_user.cart.presence || current_user.create_cart
    end
  end

  unless Rails.env.production?
    around_action :n_plus_one_detection

    def n_plus_one_detection
      Prosopite.scan
      yield
      Prosopite.raise = true
    ensure
      Prosopite.finish
    end
  end
end
