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
    @friendship_request.notifications.build
  end

  def create
    @friendship_request = FriendshipRequest.new(request_params)

    if @friendship_request.save
      flash[:notice] = "Your friend request has been sent!"
      redirect_back(fallback_location: root_path)
    else
      flash[:alert] = "Your request was not sent - it's likely you've already sent one."
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy
    @friendship_request = FriendshipRequest.find(params[:id])
    @friendship_request.destroy

    redirect_to friendship_requests_path, status: :see_other
  end

  private
    def request_params
      #debugger
      params.require(:friendship_request).permit(:request_recipient_id, :request_provider_id, notifications_attributes:[:notification_id, :recipient_id, :body])
    end
end
