class UsersController < ApplicationController
  load_and_authorize_resource :user

  respond_to :html, :json, :js

  def index
    @users = User.search(params[:search])
      .accessible_by(current_ability)
      .page(params[:page])
      .order("last_name")
  end

  def show
    @category_id = params[:category_id]
    @scraps = @user.scraps.select_by_category_id(@category_id)
      .accessible_by(current_ability).page(params[:page]).latest

    respond_with(@user)
  end

  def edit
  end

  def update
    @user.update_attributes(params[:user])
    respond_with(@user)
  end
end
