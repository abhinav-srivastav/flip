class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.references 'user'
      t.decimal 'amount', :precision => 11, :scale => 2, :default => 0
      t.text 'shiping_address'
      t.timestamps
    end
  end
end
