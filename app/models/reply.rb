class Reply < ApplicationRecord
  has_many :replies, foreign_key: :reply_id
  belongs_to :comment
  belongs_to :reply, foreign_key: :reply_id
  has_many :votes, :as => :voteable

end
