class AddCostPriceToProduct < ActiveRecord::Migration
  def change
    add_column :products, :cost_price, :decimal,:precision => 10, :scale => 2
  end
end
