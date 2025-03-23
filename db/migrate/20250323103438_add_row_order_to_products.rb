class AddRowOrderToProducts < ActiveRecord::Migration[8.0]
  def change
    add_column :products, :row_order, :integer
  end
end
