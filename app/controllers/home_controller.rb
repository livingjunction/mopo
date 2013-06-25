class HomeController < ApplicationController    
  respond_to :js, :html
  
  def index
    if !user_signed_in?
      redirect_to tour_url and return
    end
    @scraps = Scrap.accessible_by(current_ability).page(params[:page]).latest.includes(:user)
  end
  
  def tour
    render :layout => 'tour'
  end
end
