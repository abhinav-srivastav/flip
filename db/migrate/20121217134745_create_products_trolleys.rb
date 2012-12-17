class CreateProductsTrolleys < ActiveRecord::Migration
  def change
    create_table :products_trolleys, :id => false do |t|
      t.integer 'product_id'
      t.integer 'trolley_id'
    end
  end
end
