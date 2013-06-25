require 'test_helper'

class CommentsControllerTest < ActionController::TestCase
  setup do
    @scrap = FactoryGirl.create(:scrap)
    @comment = FactoryGirl.create(:comment, :scrap => @scrap)
  end
 
  test "should show comment to guest" do
    get :show, :id => @comment.to_param
    assert_redirected_to scrap_url(@comment.scrap)
  end
  
  
  test "guest should not create comment" do
    post :create, :scrap_id => @scrap, 
      :comment => @comment.attributes.slice("body"), :format => :json
    assert_redirected_to root_url
  end
  
  test "student should create comment" do
    sign_in_student
    assert_difference ['Comment.count', 'Activity.count', 'Notification.count'] do
      post :create, :scrap_id => @scrap, 
        :comment => @comment.attributes.slice("body"), :format => :json
    end
 
    assert_response :success
  end
    
  test "teacher should create comment" do
    sign_in_teacher
    assert_difference ['Comment.count', 'Activity.count', 'Notification.count'] do
      post :create, :scrap_id => @scrap, 
        :comment => @comment.attributes.slice("body"), :format => :json
    end
 
    assert_response :success
  end
  
  test "guest should not delete comment" do
    delete :destroy, :id => @comment.to_param, :format => :json
    assert_redirected_to root_url
  end
  
   
  test "should destroy comment" do
    sign_in_teacher
    assert_difference('Comment.count', -1) do
      delete :destroy, :id => @comment.to_param, :format => :json
    end
 
    assert_response :success
  end
end
