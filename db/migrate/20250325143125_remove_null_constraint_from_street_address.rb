class RemoveNullConstraintFromStreetAddress < ActiveRecord::Migration[8.0]
  def change
    change_column_null :shipping_addresses, :street_address, true
  end
end
