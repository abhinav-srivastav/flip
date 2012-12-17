class AddSlugToModels < ActiveRecord::Migration
  def change
  	add_column :products, :slug, :string
    add_index :products, :slug, :unique => true
    Product.find_each(&:save)
    add_column :categories, :slug, :string
    add_index :categories, :slug, :unique => true
    Category.find_each(&:save)
    add_column :brands, :slug, :string
    add_index :brands, :slug, :unique => true
    Brand.find_each(&:save)
  end
end
