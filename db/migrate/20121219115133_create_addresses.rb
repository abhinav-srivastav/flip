class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.string 'street no'
      t.string 'area'
      t.string 'city'
      t.integer 'postal_code'
      t.string 'country'
      t.references 'user'
      t.timestamps
    end
  end
end

