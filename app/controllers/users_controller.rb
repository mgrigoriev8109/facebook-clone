class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:show, :edit]

  def show
    @user = User.find(params[:id])
    @posts = Post.where(user_id: params[:id])
    @friendship_request = FriendshipRequest.new
    @comment = Comment.new
    @comment.notifications.build
  end

  def index
    @users = User.all
  end
end
