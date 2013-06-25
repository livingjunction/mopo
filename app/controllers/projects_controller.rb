class ProjectsController < ApplicationController
  load_and_authorize_resource :assignment, :only => [:index, :new, :create]
  load_and_authorize_resource :project, :through => :assignment, :only => [:index, :new, :create]
  load_and_authorize_resource :project, :except => [:index, :new, :create]

  respond_to :html, :json, :js

  def index
    respond_with(@projects)
  end

  def show
    @scraps = @project.scraps.accessible_by(current_ability).page(params[:page]).latest
    respond_with(@project)
  end

  def new
    @project = @assignment.projects.build
    respond_with(@project)
  end

  def edit
  end

  def create
    @project = @assignment.projects.build(params[:project])
    @project.user = current_user
    @project.save
    respond_with(@project)
  end

  def update
    @project.update_attributes(params[:project])
    respond_with(@project)
  end

  def destroy
    @assignment = @project.assignment

    @project.destroy

    if @assignment
      respond_with(@assignment,
        :location => category_assignment_url(@assignment.category, @assignment)
      )
    else
      redirect_to root_url
    end
  end
end
