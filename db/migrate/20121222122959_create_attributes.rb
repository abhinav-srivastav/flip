class CreateAttributes < ActiveRecord::Migration
  def change
    create_table :attributes do |t|
      t.string 'product_attributes'
      t.timestamps
    end
  end
end
