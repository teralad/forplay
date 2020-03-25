class RemoveColumnFromPosts < ActiveRecord::Migration[6.0]
  def change
    remove_column :posts, :subreddit_id
  end
end
