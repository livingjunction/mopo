class LinksController < ApplicationController  
  load_and_authorize_resource :link, :except => [:create]
  
  respond_to :json
  
  def create
    @link = Link.new(params[:link])
    @link.user = current_user
    @link.save
    authorize! :create, @link
    respond_with(@link)
  end
  
  def destroy
    @link.destroy
    respond_with(@link)
  end
  
end
