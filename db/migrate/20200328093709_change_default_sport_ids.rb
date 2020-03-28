class ChangeDefaultSportIds < ActiveRecord::Migration[6.0]
  def change
    change_column :posts, :sport_ids, :string
  end
end
