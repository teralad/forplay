class CreateReplies < ActiveRecord::Migration[6.0]
  def change
    create_table :replies do |t|
      t.text     "body"
      t.integer  "user_id", index: true
      t.integer  "post_id", index: true
      t.integer  "comment_id", index: true
      t.integer  "reply_id", index: true
      t.integer  "score"
      t.float    "sorting_score"
      t.timestamps
    end
  end
end
