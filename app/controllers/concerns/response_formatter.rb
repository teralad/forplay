module ResponseFormatter
  class << self
    def post_index_response(posts)
      posts.map do |post|
        post.attributes.merge{
          "sample" => "asdf"
        }
      end
    end
  end
end
