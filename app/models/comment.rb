class Comment < ApplicationRecord
  belongs_to :post
  has_many :replies
  has_many :votes, :as => :voteable

  after_commit :update_count_in_post

  def update_count_in_post
    comments_count = Comment.where(post_id: post.id).count
    post.update_column('comments_count', comments_count)
  end
end
