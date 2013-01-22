class RemoveMrpFromProduct < ActiveRecord::Migration
  def up
  	remove_column :products, :mrp
    remove_column :products, :price
    remove_column :products, :available
  end

  def down
  	add_column :prducts, :mrp, :precision => 10, :scale => 2
  	add_column :prducts, :price, :precision => 10, :scale => 2
  	add_column :prducts, :price, :default => 0    
  end
end
