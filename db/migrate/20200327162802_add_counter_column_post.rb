class AddCounterColumnPost < ActiveRecord::Migration[6.0]
  def change
    add_column :posts, :counter, :bigint, default: 0
  end
end
