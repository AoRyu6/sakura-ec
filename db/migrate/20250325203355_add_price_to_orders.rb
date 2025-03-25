class AddPriceToOrders < ActiveRecord::Migration[8.0]
  def change
    add_column :orders, :price, :integer, null: false, default: 0
  end
end
