class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.references 'order'
      t.references 'user'
      t.string 'transaction_type'
      t.decimal 'amount', :precision => 10, :scale => 2
      t.timestamps
    end
  end
end
