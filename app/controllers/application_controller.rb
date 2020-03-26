class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session

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
end
