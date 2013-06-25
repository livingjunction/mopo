require 'test_helper'

class FlagsControllerTest < ActionController::TestCase
  setup do
    @teacher = create_teacher
    @student = create_student
    @scrap = FactoryGirl.create(:scrap, :user => @student)
  end
  
  test "should show flag to guest" do
    flag = FactoryGirl.create(:flag, :scrap => @scrap, :user => @teacher)
    get :show, :id => flag.to_param
    assert_redirected_to scrap_url(flag.scrap)
  end
  
  
  test "guest should not create flag" do
    post :create, :color => :green, :scrap_id => @scrap, :format => :json
    assert_redirected_to root_url
  end
  
  test "student should not create flag" do
    sign_in @student
    post :create, :color => :green, :scrap_id => @scrap, :user_id => @student.id, :format => :json
    assert_redirected_to root_url
  end
    
  test "teacher should create flag" do
    sign_in @teacher
    assert_difference ['Flag.count', 'Activity.count', 'Notification.count'] do
      post :create, :color => :green, :scrap_id => @scrap, :user_id => @teacher.id, :format => :json
    end
 
    assert_response :success
  end
  
  test "teacher should update flag" do
    sign_in @teacher
    flag = FactoryGirl.create(:flag, :scrap => @scrap, :user => @teacher, :color => :green)
    flag.color = :red

    assert_difference ['Activity.count', 'Notification.count'] do
      put :update, :id => flag.to_param, :flag => flag.attributes.slice("color"), :format => :json
    end
    assert_response :success
    assert_equal flag.color, assigns(:flag).color
  end
  
  test "teacher should update empty flag" do
    sign_in @teacher
    flag = FactoryGirl.create(:flag, :scrap => @scrap, :user => @teacher, :color => :green)
    flag.color = nil

    put :update, :id => flag.to_param, :flag => flag.attributes.slice("color"), :format => :json
    
    assert_response :success
    assert_equal flag.color, assigns(:flag).color
    assert_equal 0, Activity.count
    assert_equal 0, Notification.count
  end
  
  
  test "guest should not delete flag" do
    flag = FactoryGirl.create(:flag, :scrap => @scrap, :user => @teacher)
    delete :destroy, :id => flag.to_param, :format => :json
    assert_redirected_to root_url
  end
  
  test "student should not delete flag" do
    flag = FactoryGirl.create(:flag, :scrap => @scrap, :user => @teacher)
    sign_in @student
    delete :destroy, :id => flag.to_param, :format => :json
    assert_redirected_to root_url
  end
   
  test "teacher should destroy flag" do
    flag = FactoryGirl.create(:flag, :scrap => @scrap, :user => @taecher)
    sign_in @teacher
    assert_difference('Flag.count', -1) do
      delete :destroy, :id => flag.to_param, :format => :json
    end
 
    assert_response :success
  end
  
end
