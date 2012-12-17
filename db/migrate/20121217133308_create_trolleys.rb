class CreateTrolleys < ActiveRecord::Migration
  def change
    create_table :trolleys do |t|
      t.string 'product_name'
      t.integer 'quantity'
      t.decimal 'amount',:precision => 10, :scale => 2
      t.timestamps
    end
  end
end
