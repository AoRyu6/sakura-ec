class ShippingAddressesController < ApplicationController
  def new
    @shipping_address = current_user.shipping_addresses.new
  end
end
