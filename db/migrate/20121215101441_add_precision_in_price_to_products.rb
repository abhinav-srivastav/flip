class AddPrecisionInPriceToProducts < ActiveRecord::Migration
  def up
  	change_column :products, :price, :decimal,:precision => 10, :scale => 2
    change_column :users, :wallet, :decimal, :precision => 10, :scale => 2
  end

  def down
  	change_column :products, :price, :decimal
  	change_column :users, :wallet, :decimal
  end
end
