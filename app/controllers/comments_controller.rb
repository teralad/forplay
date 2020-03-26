class CommentsController < ApplicationController
  before_action :authenticate_and_set_user, only: [:create, :update, :destroy]
  before_action :check_user_login_status, only: [:create, :update, :destroy]

  before_action :set_comment, only: [:show, :update, :destroy]
  before_action :set_post, only: [:create, :update, :destroy]

  # GET /comments
  def index
    @comments = Comment.all

    render json: @comments
  end

  # GET /comments/1
  def show
    render json: @comment
  end

  # POST /comments
  def create
    Rails.logger.debug "Post is #{@post}"
    @comment = @post.comments.build(comment_params)
    @comment.user_id = @user_id

    if @comment.save
      render json: @comment, status: :created
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /comments/1
  def update
    if @comment.user_id != @user_id
      render json: {error: "Forbidden"}, status: 403
      return
    end

    if @comment.post != @post
      render json: {error: "The comment does not belong to the post"}, status: 422
      return
    end

    if @comment.update(comment_params)
      render json: @comment
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  # DELETE /comments/1
  def destroy
    if @comment.user_id != @user_id
      render json: {error: "Forbidden"}, status: 403
      return
    end

    if @comment.post != @post
      render json: {error: "The comment does not belong to the post"}, status: 422
      return
    end

    @comment.destroy
  end

  private
    def set_post
      @post = Post.find(params[:post_id])
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def comment_params
      params.require(:comment).permit(:Reply, :Vote, :body)
    end
end
