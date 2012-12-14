class CreateBrands < ActiveRecord::Migration
  def change
    create_table :brands do |t|
      t.string 'brand' 
      t.references :category
      t.timestamps
    end
  end
end
