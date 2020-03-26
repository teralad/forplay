class Vote < ApplicationRecord
  belongs_to :voteable, :polymorphic => true
  after_commit :set_vote_counts

  def set_vote_counts
    upvotes, downvotes = Vote.where(voteable_id: self.voteable_id, voteable_type: self.voteable_type).pluck("sum(votes.up), sum(votes.down)").flatten
    voteable.update_columns(upvotes: upvotes.to_i, downvotes: downvotes.to_i)
  end
end

