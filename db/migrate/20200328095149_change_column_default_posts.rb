class ChangeColumnDefaultPosts < ActiveRecord::Migration[6.0]
  def change
    change_column_default :posts, :sport_ids, ''
  end
end
