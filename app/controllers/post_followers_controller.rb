class PostFollowersController < ApplicationController
  before_action :set_post_follower, only: [:show, :edit, :update]

  before_action :authenticate_and_set_user, only: [:create, :update, :destroy]
  before_action :check_user_login_status, only: [:create, :update, :destroy]
  # before_action :set_post_id, only: [:create]
  # GET /post_followers
  # GET /post_followers.json
  def index
    @post_followers = PostFollower.all
  end

  # GET /post_followers/1
  # GET /post_followers/1.json
  def show
  end

  # GET /post_followers/new
  def new
    @post_follower = PostFollower.new
  end

  # GET /post_followers/1/edit
  def edit
  end

  # POST /post_followers
  # POST /post_followers.json
  def create
    @post_follower = PostFollower.new(user_id: @user_id,post_id: params[:post_id])

    respond_to do |format|
      if @post_follower.save
        format.html { redirect_to @post_follower, notice: 'Post follower was successfully created.' }
        format.json { render :show, status: :created, location: @post_follower }
      else
        format.html { render :new }
        format.json { render json: @post_follower.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /post_followers/1
  # PATCH/PUT /post_followers/1.json
  def update
    respond_to do |format|
      if @post_follower.update(post_follower_params)
        format.html { redirect_to @post_follower, notice: 'Post follower was successfully updated.' }
        format.json { render :show, status: :ok, location: @post_follower }
      else
        format.html { render :edit }
        format.json { render json: @post_follower.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /post_followers/1
  # DELETE /post_followers/1.json
  def destroy
    @post_follower = PostFollower.find_by(user_id: @user_id, post_id: params[:post_id])
    @post_follower.destroy
    respond_to do |format|
      format.html { redirect_to post_followers_url, notice: 'Post follower was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_post_id
      @post = Post.find(params[:post_id])
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_post_follower
      @post_follower = PostFollower.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def post_follower_params
      params.fetch(:post_follower, {})
    end
end
