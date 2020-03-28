module ResponseFormatter
  class << self
    def post_index_response(posts)
      posts.map do |post|
        sports = Sport.where(id: post.sport_ids.split(',')).compact
        sport_labels = sports.map{|sport| sport['name'] }
        user_details = Cache.core.get("user:#{post.user_id}:details")
        resp = post.attributes.merge({
          sport_labels: sport_labels,
          avatar: '',
          screen_name: ''
        })
        if user_details.present?
          user = JSON.parse(user_details)
          resp[:avatar] = user['profile_pic']
          resp[:screen_name] = user['screen_name']
        end
        resp
      end
    end
  end
end
