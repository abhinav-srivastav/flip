class RenameCommentsToReviews < ActiveRecord::Migration
  def up
  	rename_column :comments, :comment, :review
  	rename_table :comments, :reviews
  end

  def down
  	rename_column :comments, :review, :comment
  	rename_table  :reviews, :comments
  end
end
