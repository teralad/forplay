module ResponseFormatter
  class << self
    def post_index_response(posts, user_id=nil)
      posts.map do |post|
        sports = Sport.where(id: post.sport_ids.split(',')).compact
        sport_labels = sports.map{|sport| sport['name'] }
        user_details = Cache.core.get("user:#{post.user_id}:details")
        resp = post.attributes.merge({
          sport_labels: sport_labels,
          avatar: '',
          screen_name: '',
          upvoted: false,
          downvoted: false
        })
        if user_details.present?
          user = JSON.parse(user_details)
          resp[:avatar] = user['profile_pic']
          resp[:screen_name] = user['screen_name']
        end

        if user_id.present?
          vote = Vote.find_by(voteable_type: 'Post', voteable_id: post.id, user_id: user_id)
          if vote.present?
            resp[:upvoted] = vote.up
            resp[:downvoted] = vote.down
          end
        end
        resp
      end
    end

    def post_show_response(post, user_id=nil)
      resp = post_index_response([post], user_id).first
      comments = post.comments.order(upvotes: :desc).limit(1)
      resp[:popular_comment] = comments.map do |comment|
        reply_count = comment.replies.count
        user_details = Cache.core.get("user:#{comment.user_id}:details")
        comment_resp = {
          id: comment.id,
          body: comment.body,
          user_id: comment.user_id,
          upvotes: comment.upvotes,
          downvotes: comment.downvotes,
          created_at: comment.created_at,
          updated_at: comment.updated_at,
          reply_count: reply_count,
          upvoted: false,
          downvoted: false,
          avatar: '',
          screen_name: ''
        }
        if user_details.present?
          user = JSON.parse(user_details)
          comment_resp[:avatar] = user['profile_pic']
          comment_resp[:screen_name] = user['screen_name']
        end

        if user_id.present?
          vote = Vote.find_by(voteable_type: 'Comment', voteable_id: comment.id, user_id: user_id)
          if vote.present?
            comment_resp[:upvoted] = vote.up
            comment_resp[:downvoted] = vote.down
          end
        end
        comment_resp
      end&.first
      resp
    end

    def comments_index_response(comments, user_id=nil)
      comments.map do |comment|
        user_details = Cache.core.get("user:#{comment.user_id}:details")
        resp = comment.attributes.merge({
          avatar: '',
          screen_name: '',
          upvoted: false,
          downvoted: false,
          replies: []
        })

        if user_details.present?
          user = JSON.parse(user_details)
          resp[:avatar] = user['profile_pic']
          resp[:screen_name] = user['screen_name']
        end

        if user_id.present?
          vote = Vote.find_by(voteable_type: 'Comment', voteable_id: comment.id, user_id: user_id)
          if vote.present?
            resp[:upvoted] = vote.up
            resp[:downvoted] = vote.down
          end
        end

        resp[:replies] = comment.replies.map do |reply|
          reply_user_details = Cache.core.get("user:#{reply.user_id}:details")
          reply_resp = reply.attributes.merge({
            avatar: '',
            screen_name: '',
            upvoted: false,
            downvoted: false
          })

          if reply_user_details.present?
            reply_user = JSON.parse(reply_user_details)
            reply_resp[:avatar] = reply_user['profile_pic']
            reply_resp[:screen_name] = reply_user['screen_name']
          end

          if user_id.present?
            reply_vote = Vote.find_by(voteable_type: 'Reply', voteable_id: reply.id, user_id: user_id)
            if vote.present?
              reply_resp[:upvoted] = vote.up
              reply_resp[:downvoted] = vote.down
            end
          end
          reply_resp
        end
        resp
      end
    end

    def replies_index_response(replies, user_id=nil)
      replies.map do |reply|
        user_details = Cache.core.get("user:#{reply.user_id}:details")
        resp = reply.attributes.merge({
          avatar: '',
          screen_name: '',
          upvoted: false,
          downvoted: false
        })

        if user_details.present?
          user = JSON.parse(user_details)
          resp[:avatar] = user['profile_pic']
          resp[:screen_name] = user['screen_name']
        end

        if user_id.present?
          vote = Vote.find_by(voteable_type: 'Reply', voteable_id: reply.id, user_id: user_id)
          if vote.present?
            resp[:upvoted] = vote.up
            resp[:downvoted] = vote.down
          end
        end
        resp
      end
    end

  end
end
