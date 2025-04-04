class ShippingAddressesController < ApplicationController
  before_action :set_shipping_address, only: %i[edit update destroy]

  def index
    @shipping_addresses = current_user.shipping_addresses.default_order
  end

  def new
    @shipping_address = current_user.shipping_addresses.new
  end

  def edit
  end

  def create
    @shipping_address = current_user.shipping_addresses.new(shipping_address_params)
    if @shipping_address.save
      redirect_to shipping_addresses_path, notice: '配送先住所を登録しました'
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

  def destroy
    @shipping_address.destroy!

    redirect_to shipping_addresses_path, status: :see_other, notice: '配送先住所を削除しました'
  end

  private

  def set_shipping_address
    @shipping_address = current_user.shipping_addresses.find(params.expect(:id))
  end

  def shipping_address_params
    params.expect(shipping_address: %i[recipient_name postal_code prefecture_id city street_address])
  end
end
