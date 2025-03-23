class Admins::Products::PositionsController < Admins::ApplicationController
  def update
    product = Product.find(params.expect(:product_id))

    product.update!(row_order_position: params.expect(:row_order_position))
  end
end
