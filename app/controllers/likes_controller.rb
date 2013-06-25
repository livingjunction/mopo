class LikesController < ApplicationController  
  load_and_authorize_resource :scrap, :only => [:create]
  load_and_authorize_resource :like
  
  respond_to :json
  
  def create
    @like = @scrap.likes.build(params[:like])
    @like.user = current_user
    @like.save
    respond_with(@like)
  end
  
  def destroy
    @like.destroy
    respond_with(@like)
  end
  
end
