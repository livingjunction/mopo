class ScrapsController < ApplicationController
  load_and_authorize_resource :project, :only => [:index]
  load_and_authorize_resource :scrap, :except => [:index]

  respond_to :html, :json

  def index
    redirect_to project_url(@project)
  end

  def show
    respond_with(@scrap)
  end

  def new
    @scrap = Scrap.new
    @project = Project.find(params[:project_id]) if params[:project_id]
    @scrap.assignment = params[:assignment_id] ? Assignment.find(params[:assignment_id]) : @project.assignment
    @scrap.project = @project if @project

    respond_with(@scrap)
  end

  def edit
  end

  def create
    @scrap = Scrap.new(params[:scrap])
    @scrap.user = current_user
    @scrap.assets << Asset.find_all_by_id(params[:assetIds]) if params[:assetIds]
    @scrap.links << Link.find_all_by_id(params[:linkIds]) if params[:linkIds]
    if @scrap.save

      Scrap.reset_counters(@scrap.id, :images, :videos, :audios, :files) if params[:assetIds]
      Scrap.reset_counters(@scrap.id, :links) if params[:linkIds]

      @scrap.reload
    end
    respond_with(@scrap)
  end

  def update
    @scrap.assign_attributes(params[:scrap])
    @scrap.assets << Asset.find_all_by_id(params[:assetIds]) if params[:assetIds]
    @scrap.links << Link.find_all_by_id(params[:linkIds]) if params[:linkIds]
    if @scrap.save

      Scrap.reset_counters(@scrap.id, :images, :videos, :audios, :files) if params[:assetIds]
      Scrap.reset_counters(@scrap.id, :links) if params[:linkIds]

      @scrap.reload
    end
    respond_with(@scrap)
  end

  def destroy
    @scrap.destroy
    if @scrap.project.present?
      object = @scrap.project
      url = project_url(@scrap.project_id)
    elsif @scrap.assignment.present?
      object = @scrap.assignment
      url = category_assignment_url(@scrap.assignment.category_id, @scrap.assignment_id)
    else
      object = @scrap.user
      url = user_url(@scrap.user)
    end
    respond_with(object, :location => url)
  end

end
