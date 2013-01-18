class RenameCostPriceToMrp < ActiveRecord::Migration
  def change
  	rename_column :products, :cost_price, :mrp
  end
end
