class CommentsController < ApplicationController

  before_action :authenticate_user!
  def index
    @comments = Comment.all
  end

  def show
    @comment = Comment.find(params[:id])
  end

  def new
    @comment = Comment.new
    @comment.notifications.build
  end

  def create
    @post = Post.find(comment_params[:post_id])
    @comment = @post.comments.build(comment_params)

    if @comment.save
      flash[:success] = "Your comment has been created!"
      redirect_back(fallback_location: root_path)
    else
      flash[:alert] = "Your new comment couldn't be created. Please check the form."
      redirect_back(fallback_location: root_path)
    end
  end

  def edit
    @comment = Comment.find(params[:id])
  end

  def update
    @comment = Comment.find(params[:id])

    if @comment.update(comment_params)
      redirect_to @comment
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy

    redirect_to root_path, status: :see_other
  end

  private
    def comment_params
      params.require(:comment).permit(:user_id, :post_id, :body, notifications_attributes:[:notification_id, :recipient_id, :body])
    end
end
