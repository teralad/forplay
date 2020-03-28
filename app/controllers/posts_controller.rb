class PostsController < ApplicationController
  before_action :authenticate_and_set_user, only: [:create, :update, :destroy]
  before_action :check_user_login_status, only: [:create, :update, :destroy]
  before_action :set_post, only: [:show, :update, :destroy]

  # GET /posts
  def index
    page = params[:page] || 1
    per = params[:per] || 10
    @posts = if params[:sport_id].present?
      Post.where("sport_ids like '%#{params[:sport_id]}%'").page(page).per(per)
    else
      Post.all.page(page).per(per)
    end

    render json: ResponseFormatter.post_index_response(@posts)
  end

  # GET /posts/1
  def show
    @post.update_column('counter', @post.counter+1)
    render json: @post
  end

  def recent
    page = params[:page] || 1
    per = params[:per] || 10
    @posts = if params[:sport_id].present?
      Post.where("sport_ids like '%#{params[:sport_id]}%'").order(updated_at: :desc).page(page).per(per)
    else
      Post.order(updated_at: :desc).page(page).per(per)
    end
    render json: ResponseFormatter.post_index_response(@posts)
  end

  def popular
    page = params[:page] || 1
    per = params[:per] || 10
    @posts = if params[:sport_id].present?
      Post.where("sport_ids like '%#{params[:sport_id]}%'").order(updated_at: :desc).page(page).per(per)
    else
      Post.order(counter: :desc).page(page).per(per)
    end
    render json: ResponseFormatter.post_index_response(@posts)
  end

  # POST /posts
  def create
    @post = Post.new(post_params)
    @post.user_id = @user_id
    if @post.save
      render json: @post, status: :created, location: @post
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /posts/1
  def update
    if @post.user_id != @user_id
      render json: {error: "Forbidden"}, status: 403
      return
    end

    if @post.update(post_params)
      render json: @post
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  # DELETE /posts/1
  def destroy
    if @post.user_id != @user_id
      render json: {error: "Forbidden"}, status: 403
      return
    end

    @post.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def post_params
      params.require(:post).permit(:Comment, :Reply, :Vote, :title, :body, :sport_ids, tags: [])
    end
end
