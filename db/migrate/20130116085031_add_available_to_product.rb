class AddAvailableToProduct < ActiveRecord::Migration
  def change
    add_column :products, :available, :integer, :default => 0
  end
end
