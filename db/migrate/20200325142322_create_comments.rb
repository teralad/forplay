class CreateComments < ActiveRecord::Migration[6.0]
  def change
    create_table :comments do |t|
      t.text     "body"
      t.integer  "user_id", index: true
      t.integer  "post_id", index: true
      t.integer  "score"
      t.float    "sorting_score"
      t.timestamps
    end
  end
end
