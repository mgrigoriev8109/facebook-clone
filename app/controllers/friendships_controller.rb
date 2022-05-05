class FriendshipsController < ApplicationController
  before_action :authenticate_user!
  def index
    @friendships = Friendship.all
  end

  def show
    @friendship = Friendship.find(params[:id])
  end

  def new
    @friendships = Friendship.all
    @friendship = Friendship.new
    @friendship.notifications.build
  end

  def create
    @friendship = Friendship.new(friendship_params)
    if @friendship.save
      delete_request
      flash[:notice] = "Your friendship has been accepted!"
      redirect_back(fallback_location: root_path)
    else
      flash[:alert] = "Your friendship was not accepted."
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy
    @friendship = Friendship.find(params[:id])
    @friendship.destroy
    redirect_to friendships_path, status: :see_other
  end

  private
    def friendship_params
      params.require(:friendship).permit(:friendship_recipient_id, :friendship_provider_id, notifications_attributes:[:notification_id, :recipient_id, :body])
    end

    def delete_request
      recipient_id = friendship_params[:friendship_recipient_id]
      provider_id = friendship_params[:friendship_provider_id]
      @friendship_request = FriendshipRequest.where(request_recipient_id: [recipient_id, provider_id]).where(request_provider_id: [recipient_id, provider_id]).first
      FriendshipRequest.destroy(@friendship_request.id)
    end
end
