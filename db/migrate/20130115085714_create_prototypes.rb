class CreatePrototypes < ActiveRecord::Migration
  def change
    create_table :prototypes do |t|
      t.string 'name'
      t.timestamps
    end
    add_column :product_attributes, :prototype_id, :integer
  end
end
