class AddPublishedToProducts < ActiveRecord::Migration[8.0]
  def change
    add_column :products, :published, :boolean, null: false, default: false
  end
end
