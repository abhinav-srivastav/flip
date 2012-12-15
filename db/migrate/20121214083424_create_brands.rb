class CreateBrands < ActiveRecord::Migration
  def change
    create_table :brands do |t|
      t.string 'brand' 
      t.timestamps
    end
  end
end
