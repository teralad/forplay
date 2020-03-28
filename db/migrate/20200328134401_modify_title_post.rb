class ModifyTitlePost < ActiveRecord::Migration[6.0]
  def change
    remove_index :posts, :title
    change_column :posts, :title, :text
    execute('alter table posts add fulltext (title, body)')
  end
end
