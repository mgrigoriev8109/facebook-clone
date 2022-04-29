class FriendshipRequestsController < ApplicationController
  before_action :authenticate_user!
  def index
    @friendship_requests = FriendshipRequest.all
  end

  def show
    @friendship_request = FriendshipRequest.find(params[:id])
  end

  def new
    @friendship_requests = FriendshipRequest.all
    @friendship_request = FriendshipRequest.new
  end

  def create
    @friendship_request = FriendshipRequest.new(request_params)

    if @friendship_request.save
      flash[:success] = "Your friend request has been sent!"
      redirect_to new_post_path
    else
      flash[:alert] = "Your friend request could not be sent. Please check the form."
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @friendship_request = FriendshipRequest.find(params[:id])
    @friendship_request.destroy

    redirect_to root_path, status: :see_other
  end

  private
    def request_params
      params.require(:friendship_request).permit(:request_recipient, :request_provider)
    end
end