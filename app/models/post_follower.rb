class PostFollower < ApplicationRecord
  belongs_to :post

  after_create :increment_count
  after_destroy :decrement_count

  def decrement_count
    post.update(followers_count: post.followers_count-1)
  end

  def update_count
    post.update(followers_count: post.followers_count+1)
  end
end
