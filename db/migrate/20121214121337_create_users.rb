class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string 'username'
      t.string 'password_digest'
      t.string 'email'
      t.boolean 'admin', :default => false
      t.decimal 'wallet', :scale => 2, :default => 10000.00
      t.timestamps
    end
  end
end
