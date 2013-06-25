require 'test_helper'

class ScrapsControllerTest < ActionController::TestCase
  setup do
    @project = FactoryGirl.create(:project)
    @scrap = FactoryGirl.create(:scrap, :project => @project)
  end

  test "should get index" do
    get :index, :project_id => @project
    assert_redirected_to project_url(@project)
  end

  test "guest should not get new when project" do
    get :new, :project_id => @project
    assert_redirected_to root_url
  end

  test "guest should not get new when assignment" do
    get :new, :assignment_id => @project.assignment_id
    assert_redirected_to root_url
  end

  test "student should get new when project" do
    sign_in_student
    get :new, :project_id => @project
    assert_response :success
  end

  test "student should get new when assignment" do
    sign_in_student
    get :new, :assignment_id => @project.assignment_id
    assert_response :success
  end

  test "teacher should get new" do
    sign_in_teacher
    get :new, :project_id => @project
    assert_response :success
  end

  test "teacher should create plain scrap" do
    asset = FactoryGirl.create(:scrap_image)
    sign_in_teacher
    assert_difference('Scrap.count') do
      post :create, :scrap => @scrap.attributes.slice(
        "name", "description", "privacy", "project_id", "assignmnet_id")
    end

    assert_redirected_to scrap_path(assigns(:scrap))
  end

  test "teacher should create scrap and join it with asset and link" do
    asset = FactoryGirl.create(:scrap_image)
    link = FactoryGirl.create(:link)
    sign_in_teacher
    assert_difference('Scrap.count') do
      post :create, :scrap => @scrap.attributes.slice(
        "name", "description", "privacy", "project_id", "assignmnet_id"),
        :assetIds => [asset.id], :linkIds => [link.id]
    end

    assert_redirected_to scrap_path(assigns(:scrap))
    assert_equal asset, assigns(:scrap).assets.first
    assert_equal 1, assigns(:scrap).images_count
    assert_equal link, assigns(:scrap).links.first
    assert_equal 1, assigns(:scrap).links_count
  end

  test "should show scrap to guest" do
    get :show, :id => @scrap.to_param
    assert_response :success

    assert_select ".edit-scrap", false
    assert_select ".delete-scrap", false
  end

  test "should show scrap to student without edit, delete links" do
    sign_in_student
    get :show, :id => @scrap.to_param
    assert_response :success

    assert_select ".edit-scrap", false
    assert_select ".delete-scrap", false
  end

  test "should show scrap to student who owns it, with edit, delete links" do
    student = sign_in_student
    scrap = FactoryGirl.create(:scrap, :user => student, :project => @project)
    get :show, :id => scrap.to_param
    assert_response :success

    assert_select ".edit-scrap"
    assert_select ".delete-scrap"
  end

  test "should show scrap with edit and delete links to teacher" do
    sign_in_teacher
    get :show, :id => @scrap.to_param
    assert_response :success

    assert_select ".edit-scrap"
    assert_select ".delete-scrap"
  end

  test "should show scrap even when assignment is deleted" do
    sign_in_teacher
    @scrap.assignment.destroy
    get :show, :id => @scrap.to_param
    assert_response :success
  end

  test "should get edit even when assignment is deleted" do
    sign_in_teacher
    @scrap.assignment.destroy
    get :edit, :id => @scrap.to_param
    assert_response :success
  end

  test "guest should not get edit" do
    get :edit, :id => @scrap.to_param
    assert_redirected_to root_url
  end

  test "student who owns scrap should get edit" do
    student = sign_in_student
    scrap = FactoryGirl.create(:scrap, :user => student, :project => @project)
    get :edit, :id => scrap.to_param
    assert_response :success
  end

  test "other student should not get edit" do
    sign_in_student
    get :edit, :id => @scrap.to_param
    assert_redirected_to root_url
  end

  test "teacher should get edit" do
    sign_in_teacher
    get :edit, :id => @scrap.to_param
    assert_response :success
  end

  test "teacher should update scrap" do
    sign_in_teacher
    put :update, :id => @scrap.to_param,
      :scrap => @scrap.attributes.slice("description")
    assert_redirected_to scrap_path(assigns(:scrap))
  end

  test "teacher should update scrap and add new asset" do
    asset = FactoryGirl.create(:scrap_image, :scrap => @scrap)
    new_asset = FactoryGirl.create(:scrap_image)
    link = FactoryGirl.create(:link, :scrap => @scrap)
    new_link= FactoryGirl.create(:link)
    sign_in_teacher
    assert_equal 1, @scrap.assets.length
    assert_equal 1, @scrap.links.length

    put :update, :id => @scrap.to_param,
      :scrap => @scrap.attributes.slice("description"),
      :assetIds => [new_asset.id],:linkIds => [new_link.id]

    assert_redirected_to scrap_path(assigns(:scrap))
    assert_equal 2, assigns(:scrap).assets.length
    assert_equal 2, assigns(:scrap).images_count
    assert_equal 2, assigns(:scrap).links.length
    assert_equal 2, assigns(:scrap).links_count
  end

  test "teacher should destroy scrap when project exists" do
    sign_in_teacher
    assert_difference('Scrap.count', -1) do
      delete :destroy, :id => @scrap.to_param
    end

    assert_redirected_to project_url(@scrap.project_id)
  end

  test "teacher should destroy scrap when no project but assignment exists" do
    sign_in_teacher
    @scrap.project.destroy
    assert_difference('Scrap.count', -1) do
      delete :destroy, :id => @scrap.to_param
    end

    assert_redirected_to category_assignment_url(@scrap.assignment.category_id, @scrap.assignment_id)
  end

  test "teacher should destroy scrap when no project, no assignment exists" do
    sign_in_teacher
    @scrap.project.destroy
    @scrap.assignment.destroy
    assert_difference('Scrap.count', -1) do
      delete :destroy, :id => @scrap.to_param
    end

    assert_redirected_to user_url(@scrap.user)
  end
end
