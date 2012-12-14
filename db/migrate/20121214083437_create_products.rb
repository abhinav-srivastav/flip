class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string 'product' 
      t.string 'type'
      t.references :brand 
      t.timestamps
    end
  end
end
