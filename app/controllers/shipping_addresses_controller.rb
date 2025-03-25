class ShippingAddressesController < ApplicationController
  before_action :set_shipping_address, only: %i[edit update]

  def index
    @shipping_addresses = current_user.shipping_addresses
  end

  def new
    @shipping_address = current_user.shipping_addresses.new
  end

  def edit
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

  def update
    if @shipping_address.update(shipping_address_params)
      redirect_to shipping_addresses_path, notice: '配送先住所を更新しました'
    else
      render :edit, status: :unprocessable_entity, notice: '更新に失敗しました'
    end
  end

  private

  def set_shipping_address
    @shipping_address = current_user.shipping_addresses.find(params.expect(:id))
  end

  def shipping_address_params
    params.expect(shipping_address: %i[recipient_name postal_code prefecture_id city street_address])
  end
end
