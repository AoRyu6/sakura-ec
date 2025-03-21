class ProductsController < ApplicationController
  def index
    # TODO: - publicizeを実装する
    @pagy, @products = pagy(Product.published.preload(image_attachment: :blob))
  end

  def show
  end
end
