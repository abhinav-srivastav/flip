class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string 'product' 
      t.string 'product_type'
      t.decimal 'price', :scale => 2
      t.references :brand 
      t.timestamps
    end
  end
end
