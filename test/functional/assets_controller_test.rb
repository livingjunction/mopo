require 'test_helper'

class AssetsControllerTest < ActionController::TestCase
  setup do
    @student = create_student
    @scrap = FactoryGirl.create(:scrap)
  end
 
  test "guest should not delete asset" do
    asset = FactoryGirl.create(:scrap_image, :scrap => @scrap, :user => @student)
    delete :destroy, :id => asset.to_param, :format => :json
    assert_redirected_to root_url
  end
   
  test "student should destroy his own asset" do
    asset = FactoryGirl.create(:scrap_image, :scrap => @scrap, :user => @student)
    sign_in :user, @student
    assert_difference('Asset.count', -1) do
      delete :destroy, :id => asset.to_param, :format => :json
    end
 
    assert_response :success
  end
  
  test "teacher should destroy student asset" do
    asset = FactoryGirl.create(:scrap_image, :scrap => @scrap, :user => @student)
    sign_in_teacher
    assert_difference('Asset.count', -1) do
      delete :destroy, :id => asset.to_param, :format => :json
    end
 
    assert_response :success
  end
end
