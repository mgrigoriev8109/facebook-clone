class LikesController < ApplicationController
  before_action :authenticate_user!
  def index
    @likes = Like.all
  end

  def show
    @like = Like.find(params[:id])
  end

  def new
    @like = Like.new
    #@like.notifications.build
  end

  def create
    @post = Post.find(like_params[:post_id])
    @like = @post.likes.build(like_params)

    if @like.save
      flash[:success] = "Your like has been created!"
      redirect_back(fallback_location: root_path)
    else
      flash[:alert] = "Your new like couldn't be created. Please check the form."
      redirect_back(fallback_location: root_path)
    end
  end

  def edit
    @like = Like.find(params[:id])
  end

  def update
    @like = Like.find(params[:id])

    if @like.update(like_params)
      redirect_to @like
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @like = Like.find(params[:id])
    @like.destroy

    redirect_to root_path, status: :see_other
  end

  private
    def like_params
      params.require(:like).permit(:user_id)
    end
end
