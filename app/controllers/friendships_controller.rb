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
  end

  def create
    @friendship = Friendship.new(friendship_params)

    if @friendship.save
      flash[:success] = "Your friendship has been accepted!"
      redirect_back(fallback_location: root_path)
    else
      flash[:alert] = "Your friendship was not accepted. Please check the form."
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy
    @friendship = Friendship.find(params[:id])
    @friendship.destroy

    redirect_to root_path, status: :see_other
  end

  private
    def friendship_params
      params.require(:friendship).permit(:friendship_recipient_id, :friendship_provider_id)
    end
end
