class CreatePostFollowers < ActiveRecord::Migration[6.0]
  def change
    create_table :post_followers do |t|
      t.integer :user_id
      t.references :post
      t.timestamps
    end
  end
end
