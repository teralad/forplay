class VotesController < ApplicationController
  before_action :authenticate_and_set_user, only: [:create, :update, :destroy]
  before_action :check_user_login_status, only: [:create, :update, :destroy]

  before_action :set_vote, only: [:show, :update, :destroy]

  # GET /votes
  def index
    @votes = Vote.all

    render json: @votes
  end

  # GET /votes/1
  def show
    render json: @vote
  end

  # POST /votes
  def create
    @voteable = if params[:post_id].present?
      Post.find_by(id: params[:post_id])
    elsif params[:comment_id].present?
      Comment.find_by(id: params[:comment_id])
    elsif params[:reply_id].present?
      Reply.find_by(id: params[:reply_id])
    end

    if @voteable.blank?
      render json: {error: "Entity is not present"}, status: 422
      return
    end

    @vote = Vote.find_or_initialize_by(user_id: @user_id, voteable_id: @voteable.id, voteable_type: @voteable.class.name)
    if (params[:up].is_a?(TrueClass) || params[:up].is_a?(FalseClass))
      @vote.up = params[:up]
      @vote.down = false
    end
    if (params[:down].is_a?(TrueClass) || params[:down].is_a?(FalseClass))
      @vote.down = params[:down]
      @vote.up = false
    end

    if @vote.save
      render json: @vote, status: :created, location: @vote
    else
      render json: @vote.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /votes/1
  def update
    if @vote.update(vote_params)
      render json: @vote
    else
      render json: @vote.errors, status: :unprocessable_entity
    end
  end

  # DELETE /votes/1
  def destroy
    @vote.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_vote
      @vote = Vote.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def vote_params
      params.fetch(:vote)
    end
end
