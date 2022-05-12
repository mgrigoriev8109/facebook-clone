class PostsController < ApplicationController
  before_action :authenticate_user!
  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @newsfeed_posts = Post.where(user_id: find_newsfeed_user_ids).sort_by(&:created_at).reverse
    @post = Post.new
    @comment = Comment.new
    @comment.notifications.build
    @like = Like.new
    @like.notifications.build
    @change_notification_color = find_unviewed_notifications
  end

  def create
    @post = current_user.posts.build(post_params)

    if @post.save
      flash[:success] = "Your post has been created!"
      redirect_back(fallback_location: root_path)
    else
      flash[:alert] = "Your new post couldn't be created. Please check the form."
      redirect_back(fallback_location: root_path)
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])

    if @post.update(post_params)
      redirect_to @post
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    redirect_to root_path, status: :see_other
  end

  private
    def post_params
      params.require(:post).permit(:body)
    end

    def find_newsfeed_user_ids
      newsfeed_ids = Friendship.where(friendship_recipient_id: current_user.id).pluck(:friendship_provider_id)
      newsfeed_ids.concat(Friendship.where(friendship_provider_id: current_user.id).pluck(:friendship_recipient_id))
      newsfeed_ids.push(current_user.id)
      newsfeed_ids
    end

    def find_unviewed_notifications
      notifications = Notification.all
      any_unviewed_notifications = false
      notifications.each do |notification|
        if notification.recipient_id == current_user.id && notification.notification_viewed == false
          any_unviewed_notifications = true
        end
      end
      any_unviewed_notifications
    end
end
