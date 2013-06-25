class NotificationsController < ApplicationController
  load_and_authorize_resource :notification
  self.responder = ActsAsApi::Responder
  respond_to :json
  
  def index
    @notifications = current_user.notifications.latest.limit(10).includes(:activity)
    respond_with(@notifications, :api_template => :notification)  
  end
  
  def update
    @notification.update_attributes(params[:notification])
    respond_with(@notification, :api_template => :notification)  
  end
end


