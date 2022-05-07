class UsersController < ApplicationController
  before_action :authenticate_user!
  def show
    @user = User.find(params[:id])
    @posts = Post.where(user_id: current_user.id)
    @friendship_request = FriendshipRequest.new
    @comment = Comment.new
  end

  def index
    @users = User.all
  end
end
