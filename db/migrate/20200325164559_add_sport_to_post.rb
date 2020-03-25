class AddSportToPost < ActiveRecord::Migration[6.0]
  def change
    add_column :posts, :sport_ids, :integer, array: true
    add_column :posts, :tags, :string, array: true
  end
end
