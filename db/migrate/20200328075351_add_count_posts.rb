class AddCountPosts < ActiveRecord::Migration[6.0]
  def change
    add_column :posts, :comments_count, :bigint, default: 0
    add_column :posts, :followers_count, :bigint, default: 0
  end
end
