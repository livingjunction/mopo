require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  setup do
    @student = FactoryGirl.create(:moomin)
  end

  test "should get index with all users ordered by last_name" do
    user1 = FactoryGirl.create(:student, :last_name => "a")
    user2 = FactoryGirl.create(:teacher, :last_name => "b")
    get :index
    assert_response :success

    assert_select "#search"
    assert_equal 3, assigns(:users).size
    assert_equal user1, assigns(:users)[0]
    assert_equal user2, assigns(:users)[1]
    assert_equal @student, assigns(:users)[2]
  end

  test "should search user by first or last name" do
    user1 = FactoryGirl.create(:student, :first_name => "firstname")
    user2 = FactoryGirl.create(:teacher, :last_name => "lastname")
    get :index, :search => "name"
    assert_response :success

    assert_equal 2, assigns(:users).size
    assert_equal user1, assigns(:users)[0]
    assert_equal user2, assigns(:users)[1]
  end

  test "guest should get show" do
    get :show, :id => @student.id
    assert_response :success

    assert_select "h2.user-header"
    assert_select "#user-info"
    assert_select "#user-scraps"

    assert_select ".edit-user", false
  end

  test "student should get show with edit link" do
    sign_in :user, @student
    get :show, :id => @student.id
    assert_response :success

    assert_select ".edit-user"
  end

  test "teacher should get show with edit link and all scraps" do
    scrap = FactoryGirl.create(:scrap, :user => @student)
    scrap2 = FactoryGirl.create(:scrap, :user => @student)
    sign_in_teacher
    get :show, :id => @student.id
    assert_response :success

    assert_select ".edit-user"
    assert_equal 2, assigns(:scraps).size
  end

  test "teacher should get show with category scraps" do
    scrap = FactoryGirl.create(:scrap, :user => @student)
    scrap2 = FactoryGirl.create(:scrap, :user => @student)
    sign_in_teacher
    get :show, :id => @student.id, :category_id => scrap.assignment.category_id
    assert_response :success

    assert_select ".edit-user"
    assert_not_equal scrap.assignment.category_id, scrap2.assignment.category_id
    assert_equal 1, assigns(:scraps).size
    assert_equal scrap, assigns(:scraps)[0]
  end


  test "guest should not get edit" do
    get :edit, :id => @student.id
    assert_redirected_to root_url
  end

  test "other student should not get edit" do
    student = create_student
    sign_in :user, student
    get :edit, :id => @student.id
    assert_redirected_to root_url
  end

  test "student/owner should get edit" do
    sign_in :user, @student
    get :edit, :id => @student.id
    assert_response :success
  end

  test "teacher should get edit" do
    sign_in_teacher
    get :edit, :id => @student.id
    assert_response :success
  end

  test "student/owner should update" do
    sign_in :user, @student
    put :update, :id => @student.id
    assert_redirected_to user_path(@student)
  end

  test "teacher should update" do
    sign_in_teacher
    put :update, :id => @student.id
    assert_redirected_to user_path(@student)
  end

end
