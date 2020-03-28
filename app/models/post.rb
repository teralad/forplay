class Post < ApplicationRecord
  has_many :comments
  has_many :votes, :as => :voteable
  after_commit :create_or_update_slug, if: proc{ |obj| obj.slug.blank? }

  enum status: { created: 0, published: 1, archived: 2, deleted: 3 }, _suffix: true

  before_create :set_status

  def set_status
    self.status = 'created'
  end

  def create_or_update_slug
    update_column('slug', generate_slug)
  end

  def generate_slug(name=self.title, counter=0)
    slug = title.blank? ? '1' : title.parameterize
    if counter != 0
      if (slug.split('-').last.to_i.is_a?(Integer) && slug.split('-').last.to_i != 0) || slug.split('-').last == '0'
        arr = slug.split('-')
        arr[arr.length-1] = counter.to_s
        slug = arr.join('-')
      else
        slug = slug + '-' + counter.to_s
      end
    end
    self.class.where(slug: slug).where.not(id: self.id).present? ? generate_slug(slug, counter+1) : slug
  end

  def self.perform_ts(search_query)
    if search_query.include?(" ")
      Post.where("match(title,body) against (? IN BOOLEAN MODE)", search_query)
    else
      Post.where("title like '%#{search_query}%'")
    end
  end
end
