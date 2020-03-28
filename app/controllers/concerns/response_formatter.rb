module ResponseFormatter
  class << self
    def post_index_response(posts)
      resp = posts.map do |post|
        post.attributes.merge{
          "sample": "asdf"
        }
      end
      resp
    end
  end
end
