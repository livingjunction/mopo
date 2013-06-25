require 'test_helper'

class ProjectsControllerTest < ActionController::TestCase
  setup do
    @assignment = FactoryGirl.create(:assignment)
    @project = FactoryGirl.create(:project, :assignment => @assignment)
  end

  test "guest should get index without new project link" do
    get :index, :assignment_id => @assignment
    assert_response :success

    assert_select "#assignment-projects"
    assert_select "#new-project", false

    assert_not_nil assigns(:assignment)
    assert_not_nil assigns(:projects)
  end

  test "student should get index with new project link" do
    sign_in_student
    get :index, :assignment_id => @assignment
    assert_response :success

    assert_select "#new-project"
  end

  test "teacher should get index with new project link" do
    sign_in_teacher
    get :index, :assignment_id => @assignment
    assert_response :success

    assert_select "#new-project"
  end

  test "guest should not get new" do
    get :new, :assignment_id => @assignment
    assert_redirected_to root_url
  end

  test "student should get new" do
    sign_in_student
    get :new, :assignment_id => @assignment
    assert_response :success
  end

  test "teacher should get new" do
    sign_in_teacher
    get :new, :assignment_id => @assignment
    assert_response :success
  end

  test "teacher should create project" do
    sign_in_teacher
    assert_difference('Project.count') do
      post :create, :assignment_id => @assignment, :project => @project.attributes.slice("name")
    end

    assert_redirected_to project_path(assigns(:project))
  end

  test "should show project to guest" do
    private_scrap = FactoryGirl.create(:private_scrap, :project => @project)
    public_scrap = FactoryGirl.create(:public_scrap, :project => @project)

    get :show, :assignment_id => @assignment, :id => @project.to_param
    assert_response :success

    assert_select 'h2', @assignment.category.name
    assert_select "#assignment-info"
    assert_select "#project-selector"
    assert_select "#project-info"
    assert_select "#project-scraps"

    assert_select ".edit-project", false
    assert_select ".delete-project", false
    assert_select "#new-scrap", false

    assert_not_nil assigns(:scraps)
    assert_equal 1, assigns(:scraps).length
    assert_equal public_scrap, assigns(:scraps)[0]
  end

  test "should show project to other student without edit, delete links" do
    student = sign_in_student
    private_scrap = FactoryGirl.create(:private_scrap, :project => @project)
    private_scrap_owner = FactoryGirl.create(
      :private_scrap, :project => @project, :user => student)
    public_scrap = FactoryGirl.create(:public_scrap, :project => @project)

    get :show, :assignment_id => @assignment, :id => @project.to_param
    assert_response :success

    assert_select ".edit-project", false
    assert_select ".delete-project", false
    assert_select "#new-scrap"

    assert_not_nil assigns(:scraps)
    assert_equal 2, assigns(:scraps).length
    assert_equal public_scrap, assigns(:scraps)[0]
    assert_equal private_scrap_owner, assigns(:scraps)[1]
  end

  test "should show project to student who owns it with edit and delete links" do
    student = sign_in_student
    project = FactoryGirl.create(:project, :user => student, :assignment => @assignment)
    get :show, :assignment_id => @assignment, :id => project.to_param
    assert_response :success

    assert_select ".edit-project"
    assert_select ".delete-project"
    assert_select "#new-scrap"
  end

  test "should show project with edit and delete links to teacher" do
    sign_in_teacher
    private_scrap = FactoryGirl.create(:private_scrap, :project => @project)
    public_scrap = FactoryGirl.create(:public_scrap, :project => @project)

    get :show, :assignment_id => @assignment, :id => @project.to_param
    assert_response :success

    assert_select ".edit-project"
    assert_select ".delete-project"
    assert_select "#new-scrap"

    assert_not_nil assigns(:scraps)
    assert_equal 2, assigns(:scraps).length
    assert_equal public_scrap, assigns(:scraps)[0]
    assert_equal private_scrap, assigns(:scraps)[1]
  end

  test "should show project even when assignment is deleted" do
    sign_in_teacher
    @assignment.destroy
    get :show, :assignment_id => @assignment, :id => @project.to_param
    assert_response :success

    assert_select "#project-name"
    assert_select "#project-selector", false
  end

  test "guest should not get edit" do
    get :edit, :assignment_id => @assignment, :id => @project.to_param
    assert_redirected_to root_url
  end

  test "student who owns project should get edit" do
    student = sign_in_student
    project = FactoryGirl.create(:project, :user => student, :assignment => @assignment)
    get :edit, :assignment_id => @assignment, :id => project.to_param
    assert_response :success
  end

  test "other student should not get edit" do
    sign_in_student
    get :edit, :assignment_id => @assignment, :id => @project.to_param
    assert_redirected_to root_url
  end

  test "teacher should get edit" do
    sign_in_teacher
    get :edit, :assignment_id => @assignment, :id => @project.to_param
    assert_response :success
  end

  test "teacher should update project" do
    sign_in_teacher
    put :update, :assignment_id => @assignment, :id => @project.to_param, :project => @project.attributes.slice("name")
    assert_redirected_to project_path(assigns(:project))
  end

  test "teacher should destroy project" do
    sign_in_teacher
    assert_difference('Project.count', -1) do
      delete :destroy, :assignment_id => @assignment, :id => @project.to_param
    end

    assert_redirected_to category_assignment_url(@assignment.category, @assignment)
  end
end
