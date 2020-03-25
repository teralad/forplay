class Comment < ApplicationRecord
  belongs_to :post
  has_many :replies
  has_many :votes, :as => :voteable
end
