class CreateTableProductsPrototypes < ActiveRecord::Migration
  def change
    create_table :products_prototypes, :id => false do |t|
      t.references 'product'
      t.references 'prototype'
    end
  end
end
