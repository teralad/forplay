class RenameColumns < ActiveRecord::Migration[6.0]
  def change
    rename_column :posts, :upvotes_count, :upvotes
    rename_column :comments, :upvotes_count, :upvotes
    rename_column :replies, :upvotes_count, :upvotes

    rename_column :posts, :downvotes_count, :downvotes
    rename_column :comments, :downvotes_count, :downvotes
    rename_column :replies, :downvotes_count, :downvotes
  end
end
