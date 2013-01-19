class CreateVarients < ActiveRecord::Migration
  def change
  	create_table :colours do |t|
      t.string 'colour'
  	end
  	create_table :sizes do |t|
      t.string 'size'
  	end  	
    create_table :varients do |t|
      t.references 'product'
      t.decimal 'mrp', :precision => 10, :scale => 2
      t.decimal 'price', :precision => 10, :scale => 2
      t.integer 'available', :default => 0
      t.references 'colour'
      t.references 'size'
      t.timestamps
    end
  end
end
