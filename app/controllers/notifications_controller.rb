class NotificationsController < ApplicationController
  def index
    @notifications = Notification.all
  end

  def show
    @notification = Notification.find(params[:id])
  end

  def new
    @notification = Notification.new
  end

  def create
    @notification = Notification.new(notification_params)

    if @notification.save
      flash[:notice] = "Your notification has been sent!"
      redirect_back(fallback_location: root_path)
    else
      flash[:alert] = "Your notification was not sent."
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy
    @notification = Notification.find(params[:id])
    @notification.destroy
    redirect_to root_path, status: :see_other
  end

  private
    def notification_params
      params.require(:notification).permit(:body)
    end
end
