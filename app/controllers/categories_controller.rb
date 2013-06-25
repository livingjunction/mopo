class CategoriesController < ApplicationController
  load_and_authorize_resource :category
  
  respond_to :html, :json, :js
  
  def show
    @scraps = @category.scraps.accessible_by(current_ability)
      .page(params[:page]).latest.includes(:user)
      
    respond_with(@category)
  end
  
end
