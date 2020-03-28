module ResponseFormatter
  class << self
    def post_index_response(posts)
      posts.map do |post|
        sports = Sport.where(id: post.sport_ids.split(',')).compact
        sport_labels = sports.map{|sport| sport['name'] }
        user_details = Cache.core.get("user:#{post.user_id}:details")
        user = JSON.parse(user_details)
        post.attributes.merge({
          sport_labels: sport_labels,
          avatar: user['profile_pic'],
          screen_name: user['screen_name']
        })
      end
    end
  end
end
