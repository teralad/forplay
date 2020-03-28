class ApplicationController < ActionController::Base
  protect_from_forgery #with: :null_session
  # skip_before_action :verify_authenticity_token
  # protect_from_forgery prepend: true, with: :exception

  before_action :authenticate_and_set_user, only: :summary

  def authenticate_and_set_user
    token = request.headers['HTTP_AUTHORIZATION']&.split(' ')&.last
    Rails.logger.info "Header auth is #{request.headers['HTTP_AUTHORIZATION']}"
    if token&.count('.') == 2
      decoded_token, = JWT.decode token, AUTH_PUBLIC_KEY, true, algorithm: 'RS256'
      @user_id, @role_id, @jti = decoded_token.values_at('user_id', 'role_id', 'jti')
    end
  rescue StandardError => e
    raise "Error with token sent. #{e.message}"
  end

  def check_user_login_status
    unless Cache.core.get("jwt:#{@user_id}:#{@jti}").present?
      render json: {error: 'User not logged in'}, status: 401
    end
  end

  def summary
    pc = Post.where(user_id: @user_id).count
    cc = Comment.where(user_id: @user_id).count
    rc = Reply.where(user_id: @user_id).count
    comments_count = Post.joins(:comments).where(user_id: @user_id).count
    resp = {
      no_of_posts: (pc || 0),
      no_of_comments: (cc || 0),
      no_of_replies: (rc || 0),
      no_of_comments_on_my_posts: (comments_count || 0)
    }
    render json: resp
  end
end
