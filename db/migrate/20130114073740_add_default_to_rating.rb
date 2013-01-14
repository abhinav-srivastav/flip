class AddDefaultToRating < ActiveRecord::Migration
  def change
  	change_column :ratings, :rating, :integer, :default => 1
  end
end
