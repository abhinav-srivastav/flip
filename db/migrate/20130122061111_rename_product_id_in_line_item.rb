class RenameProductIdInLineItem < ActiveRecord::Migration
  def change
  	rename_column :line_items, :product_id, :varient_id
  end
end
