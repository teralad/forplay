class ChangeColumnDefault < ActiveRecord::Migration[6.0]
  def change
    change_column_default :posts, :upvotes, 0
    change_column_default :comments, :upvotes, 0
    change_column_default :replies, :upvotes, 0
    change_column_default :posts, :downvotes, 0
    change_column_default :comments, :downvotes, 0
    change_column_default :replies, :downvotes, 0
  end
end
