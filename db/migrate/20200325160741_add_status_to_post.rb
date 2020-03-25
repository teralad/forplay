class AddStatusToPost < ActiveRecord::Migration[6.0]
  def change
    add_column :posts, :status, :integer
    add_column :posts, :upvotes_count, :bigint
    add_column :posts, :downvotes_count, :bigint

    add_column :comments, :upvotes_count, :bigint
    add_column :comments, :downvotes_count, :bigint

    add_column :replies, :upvotes_count, :bigint
    add_column :replies, :downvotes_count, :bigint

  end
end
