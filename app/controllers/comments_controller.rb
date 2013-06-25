class CommentsController < ApplicationController
  load_and_authorize_resource :scrap, :only => [:create]
  load_and_authorize_resource :comment
  
  respond_to :json
  
  def show
    redirect_to scrap_url(@comment.scrap)
  end
  
  def create
    @comment = @scrap.comments.build(params[:comment])
    @comment.user = current_user
    if @comment.save
      notify_about_activity @scrap.user, @comment
    end
    respond_with(@comment)
  end
  
  def destroy
    @comment.destroy

    respond_with(@scrap) do |format|
      format.html { redirect_to scrap_url(@scrap) }
    end
  end
  
end
