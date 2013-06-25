require 'test_helper'

class AssignmentsControllerTest < ActionController::TestCase
  setup do
    @category = FactoryGirl.create(:category)
    @assignment = FactoryGirl.create(:assignment, :category => @category, :position => 1)
  end

  test "guest should get index without new assignment link and order handler, ordered by position" do
    assignment3 = FactoryGirl.create(:assignment, :category => @category, :position => 3)
    assignment2 = FactoryGirl.create(:assignment, :category => @category, :position => 2)
    student = create_student
    get :index, :category_id => @category
    assert_response :success

    assert_select "#category-assignments"
    assert_select "#new-assignment", false
    assert_select ".handle", false

    assert_not_nil assigns(:category)
    assert_not_nil assigns(:assignments)
    assert_equal 3, assigns(:assignments).size
    assert_equal @assignment, assigns(:assignments)[0]
    assert_equal assignment2, assigns(:assignments)[1]
    assert_equal assignment3, assigns(:assignments)[2]
  end

  test "student should get index without new assignment link and order handler" do
    sign_in_student
    get :index, :category_id => @category
    assert_response :success

    assert_select "#new-assignment", false
    assert_select ".handle", false
  end

  test "teacher should get index with new assignment link and order handler" do
    sign_in_teacher
    get :index, :category_id => @category
    assert_response :success

    assert_select "#new-assignment"
    assert_select ".handle"
  end

  test "guest should not get new" do
    get :new, :category_id => @category
    assert_redirected_to root_url
  end

  test "student should not get new" do
    sign_in_student
    get :new, :category_id => @category
    assert_redirected_to root_url
  end

  test "teacher should get new" do
    sign_in_teacher
    get :new, :category_id => @category
    assert_response :success
  end

  test "guest should not create assignment" do
    post :create, :category_id => @category, :assignment => @assignment.attributes.slice("name", "description")
    assert_redirected_to root_url
  end

  test "student should not create assignment" do
    sign_in_student
    post :create, :category_id => @category, :assignment => @assignment.attributes.slice("name", "description")
    assert_redirected_to root_url
  end

  test "teacher should create assignment" do
    sign_in_teacher
    assert_difference('Assignment.count') do
      post :create, :category_id => @category, :assignment => @assignment.attributes.slice("name", "description")
    end

    assert_redirected_to category_assignment_path(@category, assigns(:assignment))
  end

  test "should show assignment without edit and delete links to guest" do
    project = FactoryGirl.create(:project, :assignment => @assignment)
    private_scrap = FactoryGirl.create(:private_scrap, :project => project)
    public_scrap = FactoryGirl.create(:public_scrap, :project => project)

    get :show, :category_id => @category, :id => @assignment.to_param
    assert_response :success

    assert_select 'h2', @category.name
    assert_select "#assignment-info"
    assert_select "#project-selector"
    assert_select "#assignment-scraps"

    assert_select ".edit-assignment", false
    assert_select ".delete-assignment", false
    assert_select "#new-scrap", false

    assert_not_nil assigns(:scraps)
    assert_equal 1, assigns(:scraps).length
    assert_equal public_scrap, assigns(:scraps)[0]
  end

  test "should show assignment without edit and delete links to student" do
    student = sign_in_student
    project = FactoryGirl.create(:project, :assignment => @assignment)
    private_scrap = FactoryGirl.create(:private_scrap, :project => project)
    private_scrap_owner = FactoryGirl.create(
      :private_scrap, :project => project, :user => student)
    public_scrap = FactoryGirl.create(:public_scrap, :project => project)

    get :show, :category_id => @category, :id => @assignment.to_param
    assert_response :success

    assert_select ".edit-assignment", false
    assert_select ".delete-assignment", false
    assert_select "#new-scrap"

    assert_not_nil assigns(:scraps)
    assert_equal 2, assigns(:scraps).length
    assert_equal public_scrap, assigns(:scraps)[0]
    assert_equal private_scrap_owner, assigns(:scraps)[1]
  end

  test "should show assignment with edit and delete links to teacher" do
    student = create_student
    sign_in_teacher
    project = FactoryGirl.create(:project, :assignment => @assignment)
    private_scrap = FactoryGirl.create(:private_scrap, :project => project)
    public_scrap = FactoryGirl.create(:public_scrap, :project => project)

    get :show, :category_id => @category, :id => @assignment.to_param
    assert_response :success

    assert_select ".edit-assignment"
    assert_select ".delete-assignment"
    assert_select "#new-scrap"

    assert_not_nil assigns(:scraps)
    assert_equal 2, assigns(:scraps).length
    assert_equal public_scrap, assigns(:scraps)[0]
    assert_equal private_scrap, assigns(:scraps)[1]
  end

  test "guest should not get edit" do
    get :edit, :category_id => @category, :id => @assignment.to_param
    assert_redirected_to root_url
  end

  test "student should not get edit" do
    sign_in_student
    get :edit, :category_id => @category, :id => @assignment.to_param
    assert_redirected_to root_url
  end

  test "teacher should get edit" do
    sign_in_teacher
    get :edit, :category_id => @category, :id => @assignment.to_param
    assert_response :success
  end

  test "guest should not update" do
    put :update, :category_id => @category, :id => @assignment.to_param, :assignment => @assignment.attributes.slice("name", "description")
    assert_redirected_to root_url
  end

  test "student should not update" do
    sign_in_student
    put :update, :category_id => @category, :id => @assignment.to_param, :assignment => @assignment.attributes.slice("name", "description")
    assert_redirected_to root_url
  end

  test "teacher should update assignment" do
    sign_in_teacher
    put :update, :category_id => @category, :id => @assignment.to_param, :assignment => @assignment.attributes.slice("name", "description")
    assert_redirected_to category_assignment_path(@category, assigns(:assignment))
  end

  test "guest should not destroy" do
    delete :destroy, :category_id => @category, :id => @assignment.to_param
    assert_redirected_to root_url
  end

  test "student should not destroy" do
    sign_in_student
    delete :destroy, :category_id => @category, :id => @assignment.to_param
    assert_redirected_to root_url
  end

  test "teacher should destroy assignment" do
    sign_in_teacher
    assert_difference('Assignment.count', -1) do
      delete :destroy, :category_id => @category, :id => @assignment.to_param
    end

    assert_redirected_to category_path(@category)
  end

  test "guest should not sort" do
    post :sort, :assignment => [@assignment.id]
    assert_redirected_to root_url
  end

  test "student should not sort" do
    sign_in_student
    post :sort, :assignment => [@assignment.id]
    assert_redirected_to root_url
  end

  test "teacher should sort" do
    assignment2 = FactoryGirl.create(:assignment, :category => @category, :position => 2)
    sign_in_teacher
    post :sort, :assignment => [assignment2.id, @assignment.id]

    assert_response :success
    assert_equal 1, assignment2.reload.position
    assert_equal 2, @assignment.reload.position
  end
end
