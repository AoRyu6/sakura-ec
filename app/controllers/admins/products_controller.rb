class Admins::ProductsController < ApplicationController
  def index
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to admins_products_path, notice: '商品を登録しました'
    else
      render :new, status: :unprocessable_entity

    end
  end

  private

  def product_params
    params.expect(product: %i[name price_before_tax description])
  end
end
