require 'test_helper'

class HomeControllerTest < ActionController::TestCase
  setup do
    @student = create_student
    @public_scrap = FactoryGirl.create(:public_scrap, :user => @student)
    @private_scrap = FactoryGirl.create(:private_scrap, :user => @student)
  end
  
  test "guest should be redirected to tour" do
    get :index
    assert_redirected_to tour_url
  end

  test "student should get index with profile link, all scraps, latest first" do
    sign_in :user, @student
    get :index
    assert_response :success 
  end  

  test "teacher should get index with profile link, all scraps, latest first" do
    sign_in_teacher
    get :index
    assert_response :success 
    
    #test header
    assert_select 'a[href="#categories-panel"]'
    assert_select 'a.user-profile-link'
    assert_select 'a.user-notifications-link'
    
    #test scraps   
    assert_not_nil assigns(:scraps)
    assert_equal 2, assigns(:scraps).length
    assert_equal @private_scrap, assigns(:scraps)[0]
    assert_equal @public_scrap, assigns(:scraps)[1]
    
    #test panels
    assert_select '#categories-panel'
    assert_select '#notifications-panel'
  end

  test "guest should get tour" do
    get :tour
    assert_response :success
  end
  
  test "student should get tour" do
    sign_in :user, @student
    get :tour
    assert_response :success
  end
  
  test "teacher should get tour" do
    sign_in_teacher
    get :tour
    assert_response :success
  end
end
