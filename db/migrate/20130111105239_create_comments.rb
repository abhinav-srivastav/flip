class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.references 'product'
      t.references 'user'
      t.string 'comment'
      t.timestamps
    end
  end
end
