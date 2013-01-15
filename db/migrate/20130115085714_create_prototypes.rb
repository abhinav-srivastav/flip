class CreatePrototypes < ActiveRecord::Migration
  def change
    create_table :prototypes do |t|
      t.string 'name'
      t.timestamps
    end
    create_table :product_attributes_prototypes, :id => false do |t|
      t.references 'prototype'
      t.references 'product_attribute'
    end
  end
end
