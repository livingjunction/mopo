class AssignmentsController < ApplicationController
  load_and_authorize_resource :category, :except => [:sort]
  load_and_authorize_resource :assignment, :through => :category, :except => [:sort]

  respond_to :html, :json, :js

  def index
    @assignments = @assignments.order("position")
    respond_with(@assignments)
  end

  def show
    @scraps = @assignment.scraps.accessible_by(current_ability)
      .page(params[:page]).latest.includes(:user)

    respond_with(@assignment)
  end

  def new
    @assignment = @category.assignments.build
    respond_with(@assignment)
  end

  def edit
  end

  def create
    @assignment = @category.assignments.build(params[:assignment])
    @assignment.user = current_user
    @assignment.save
    respond_with(@category, @assignment)
  end

  def update
    @assignment.update_attributes(params[:assignment])
    respond_with(@category, @assignment)
  end

  def destroy
    @assignment.destroy
    respond_with(@category, :location => category_url(@category))
  end

  def sort
    authorize! :update, Assignment
    params[:assignment].each_with_index do |id, index|
      Assignment.update_all({position: index+1}, {id: id})
    end
    render nothing: true
  end
end
