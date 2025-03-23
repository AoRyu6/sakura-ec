class ChangePriceBeforeTaxToMonetizeInProducts < ActiveRecord::Migration[8.0]
  def up
    remove_column :products, :price_before_tax
    add_monetize :products, :price, amount: { null: true, default: nil }
  end

  def down
    add_column :products, :price_before_tax, :integer
    remove_monetize :products, :price
  end
end
