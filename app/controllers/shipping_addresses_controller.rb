class ShippingAddressesController < ApplicationController
  def index
    @shipping_addresses = current_user.shipping_addresses
  end

  def new
    @shipping_address = current_user.shipping_addresses.new
  end

  def create
    @shipping_address = current_user.shipping_addresses.new(shipping_address_params)
    if @shipping_address.save
      # TODO: - showを実装していないため、root_pathにリダイレクトしている
      redirect_to root_path, notice: '配送先住所を登録しました'
    else
      render :new, status: :unprocessable_entity, notice: '配送先住所の登録に失敗しました'
    end
  end

  private

  def shipping_address_params
    params.expect(shipping_address: %i[recipient_name postal_code prefecture_id city street_address])
  end
end
