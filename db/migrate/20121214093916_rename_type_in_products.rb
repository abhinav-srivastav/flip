class RenameTypeInProducts < ActiveRecord::Migration
  def up
  	rename_column :products, :type, :product_type
  end

  def down
  	rename_column :products, :product_type, :type
  end
end
