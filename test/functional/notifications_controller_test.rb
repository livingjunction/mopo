require 'test_helper'

class NotificationsControllerTest < ActionController::TestCase
  setup do
    @teacher = create_teacher
    @student = create_student
    @notification = FactoryGirl.create(:notification, :user => @student)
  end

  test "student should update his own notification" do
    sign_in @student
    notification = FactoryGirl.create(:notification, :user => @student, :is_read => false)
    notification.is_read = true

    put :update, :id => notification.to_param, :notification => notification.attributes.slice("is_read"), :format => :json
    
    assert_response :success
    assert_equal notification.is_read, assigns(:notification).is_read
  end

   
  test "teacher should not update student notification" do
    sign_in @teacher
    notification = FactoryGirl.create(:notification, :user => @student)
    notification.is_read = true
    
    put :update, :id => notification.to_param, :notification => notification.attributes.slice("is_read"), :format => :json
    
    assert_redirected_to root_url
  end
   
end
