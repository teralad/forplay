class AddIndexesPosts < ActiveRecord::Migration[6.0]
  def change
    add_index :posts, :sport_ids
    add_index :posts, :counter
    add_index :posts, :updated_at
    change_column_default :posts, :tags, ''
  end
end
