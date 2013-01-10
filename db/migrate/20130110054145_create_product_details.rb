class CreateProductDetails < ActiveRecord::Migration
  def change
    create_table :product_details do |t|
      t.references 'product_attribute'
      t.references 'product'
      t.text 'details'
      t.timestamps
    end
  end
end
