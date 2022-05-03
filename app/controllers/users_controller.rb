class UsersController < ApplicationController
  before_action :authenticate_user!
  def show
    @user = User.find(params[:id])
    @posts = Post.all
    @friendship_request = FriendshipRequest.new
  end

  def index
    @users = User.all
  end
end
