class RenameShipingAddressInOrder < ActiveRecord::Migration
  def change
  	remove_column :orders, :shiping_address
  	add_column :orders, :address_id, :integer
  end
end