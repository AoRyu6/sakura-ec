class ProductsController < ApplicationController
  def index
    # TODO: - publicizeを実装する
    @pagy, @products = pagy(Product.published.preload(image_attachment: :blob))
  end

  def show
    @product = Product.find(params.expect(:id))
  end
end
