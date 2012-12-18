class CreateLineItems < ActiveRecord::Migration
  def change
    create_table :line_items do |t|
      t.references 'product'
      t.integer 'quantity', :default => 1
      t.decimal 'price', :precision => 10, :scale => 2
      t.references 'order'
      t.timestamps
    end
  end
end
