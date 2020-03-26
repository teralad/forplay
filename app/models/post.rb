class Post < ApplicationRecord
  has_many :comments
  has_many :votes, :as => :voteable
  after_commit :create_or_update_slug, if: :bad_slug

  enum status: { created: 0, published: 1, archived: 2, deleted: 3 }, _suffix: true

  before_create :set_status

  def set_status
    self.status = 'created'
  end

  def bad_slug
    self.slug != new_slug
  end

  def new_slug
    "#{self.id}-#{title.parameterize}"
  end

  def create_or_update_slug
    update_column('slug', new_slug)
  end
end
