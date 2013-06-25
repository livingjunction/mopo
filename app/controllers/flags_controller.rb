class FlagsController < ApplicationController  
  load_and_authorize_resource :scrap, :only => [:create]
  load_and_authorize_resource :flag
  
  respond_to :json
  
  def show
    redirect_to scrap_url(@flag.scrap)
  end
  
  def create
    @flag = @scrap.build_flag(params[:flag])
    @flag.user = current_user
    if @flag.save
      notify_about_activity @scrap.user, @flag
    end
    respond_with(@flag)
  end
  
  def update
    if @flag.update_attributes(params[:flag])
      notify_about_activity @flag.scrap.user, @flag if params[:flag][:color]
    end
    respond_with(@flag)
  end  
  
  def destroy
    @flag.destroy
    respond_with(@flag)
  end
  
end
