class Reply < ApplicationRecord
  belongs_to :comment
  has_many :votes, :as => :voteable

end
