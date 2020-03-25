class RepliesController < ApplicationController
  before_action :authenticate_and_set_user, only: [:create, :update, :destroy]
  before_action :check_user_login_status, only: [:create, :update, :destroy]

  before_action :set_parent, only: [:create, :update, :destroy]
  before_action :set_reply, only: [:show, :update, :destroy]

  # GET /replies
  def index
    @replies = Reply.all

    render json: @replies
  end

  # GET /replies/1
  def show
    render json: @reply
  end

  # POST /replies
  def create
    @reply = @parent.replies.build({body:params[:body]})
    @reply.user_id = @user_id

    if @reply.save
      render json: @reply, status: :created, location: @reply
    else
      render json: @reply.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /replies/1
  def update
    if @reply.user_id != @user_id
      render json: {error: "Unauthorized", status: 401}
      return
    end

    if @reply.update(reply_params)
      render json: @reply
    else
      render json: @reply.errors, status: :unprocessable_entity
    end
  end

  # DELETE /replies/1
  def destroy
    if @reply.user_id != @user_id
      render json: {error: "Unauthorized", status: 401}
      return
    end

    @reply.destroy
  end

  private
    def set_parent
      @parent = if params[:comment_id].present?
        Comment.find_by(id: params[:comment_id])
      elsif params[:reply_id].present?
        Reply.find_by(id: params[:reply_id]).comment
      end
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_reply
      @reply = Reply.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def reply_params
      params.require(:reply).permit(:Vote, :body)
    end
end
