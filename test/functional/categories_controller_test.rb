require 'test_helper'

class CategoriesControllerTest < ActionController::TestCase
  setup do
    @category = FactoryGirl.create(:category)
    @assignment = FactoryGirl.create(:assignment, :category => @category)
    @project = FactoryGirl.create(:project, :assignment => @assignment)        
    @private_scrap = FactoryGirl.create(:private_scrap, project: @project) 
    @registered_scrap = FactoryGirl.create(:registered_scrap, project: @project) 
    @public_scrap = FactoryGirl.create(:public_scrap, project: @project) 
  end
  
  test "guest should see login link and no notifications in header" do
    get :show, :id => @category
    assert_response :success

    assert_select 'a.user-login-link'
    assert_select 'a.user-profile-link', false
    assert_select 'a.user-notifications-link', false
    
    assert_select '#categories-panel'
    assert_select '#notifications-panel', false
  end

  test "should show category to guest with public scrap" do
    get :show, :id => @category
    assert_response :success
     
    assert_select 'h2', @category.name
    assert_select '#assignment-selector'
    assert_select '#category-scraps'

    assert_not_nil assigns(:scraps)
    assert_equal 1, assigns(:scraps).length
    assert_equal @public_scrap, assigns(:scraps)[0]
  end

  test "should show category to student without private scrap" do
    student = sign_in_student
    private_scrap_owner = FactoryGirl.create(
      :private_scrap, :project => @project, :user => student) 
    get :show, :id => @category
    assert_response :success
    
    assert_not_nil assigns(:scraps)
    assert_equal 3, assigns(:scraps).length
    assert_equal private_scrap_owner, assigns(:scraps)[0]
    assert_equal @public_scrap, assigns(:scraps)[1]
    assert_equal @registered_scrap, assigns(:scraps)[2]
  end
  
  test "should show category to teacher with all scraps" do
    sign_in_teacher
    get :show, :id => @category
    assert_response :success
    
    assert_not_nil assigns(:scraps)
    assert_equal 3, assigns(:scraps).length
  end
end
