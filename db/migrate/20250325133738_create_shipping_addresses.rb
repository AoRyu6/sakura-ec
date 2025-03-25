class CreateShippingAddresses < ActiveRecord::Migration[8.0]
  def change
    create_table :shipping_addresses do |t|
      t.string :recipient_name, null: false
      t.string :postal_code, null: false
      t.integer :prefecture_id, null: false
      t.string :city, null: false
      t.string :street_address, null: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
