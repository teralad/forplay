class CreatePosts < ActiveRecord::Migration[6.0]
  def change
    create_table :posts do |t|
      t.string   "title"
      t.text     "body"
      t.integer  "user_id"
      t.float    "sorting_score"
      t.integer  "score"
      t.integer  "subreddit_id"
      t.timestamps
    end
  end
end
