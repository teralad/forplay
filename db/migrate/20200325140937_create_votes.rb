class CreateVotes < ActiveRecord::Migration[6.0]
  def change
    create_table :votes do |t|
      t.boolean  "up"
      t.boolean  "down"
      t.integer  "user_id", index: true
      t.references :voteable, polymorphic: true, index: true
      t.timestamps
    end
  end
end
