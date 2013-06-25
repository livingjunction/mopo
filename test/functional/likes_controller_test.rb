require 'test_helper'

class LikesControllerTest < ActionController::TestCase
  setup do
    @student = create_student
    @scrap = FactoryGirl.create(:scrap)
  end
  
  test "guest should not create like" do
    post :create, :scrap_id => @scrap, :user_id => @student.id, :format => :json
    assert_redirected_to root_url
  end
  
  test "student should create like" do
    sign_in_student
    assert_difference('Like.count') do
      post :create, :scrap_id => @scrap, :user_id => @student.id, :format => :json
    end
 
    assert_response :success
  end
    
  test "teacher should create like" do
    sign_in_teacher
    assert_difference('Like.count') do
      post :create, :scrap_id => @scrap, :user_id => @student.id, :format => :json
    end
 
    assert_response :success
  end
  
  test "guest should not delete like" do
    like = FactoryGirl.create(:like, :scrap => @scrap, :user => @student)
    delete :destroy, :id => like.to_param, :format => :json
    assert_redirected_to root_url
  end
  
   
  test "student should destroy his own like" do
    like = FactoryGirl.create(:like, :scrap => @scrap, :user => @student)
    sign_in :user, @student
    assert_difference('Like.count', -1) do
      delete :destroy, :id => like.to_param, :format => :json
    end
 
    assert_response :success
  end
  
  test "teacher should NOT destroy student like" do
    like = FactoryGirl.create(:like, :scrap => @scrap, :user => @student)
    sign_in_teacher
    delete :destroy, :id => like.to_param, :format => :json
    assert_redirected_to root_url
  end
end
