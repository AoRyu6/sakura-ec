class ProductsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index show]

  def index
    @pagy, @products = pagy(Product.published.preload(image_attachment: :blob).sorted_by_rank.default_order)
  end

  def show
    @product = Product.find(params.expect(:id))
  end
end
