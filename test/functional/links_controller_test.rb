require 'test_helper'

class LinksControllerTest < ActionController::TestCase
  setup do
    @scrap = FactoryGirl.create(:scrap)
    @link = FactoryGirl.create(:link)
  end
  
  test "guest should not create link" do
    post :create, :scrap_id => @scrap, :link => @link.attributes.slice("url"), :format => :json
    assert_redirected_to root_url
  end
  
  test "student should create link" do
    sign_in_student
    assert_difference('Link.count') do
      post :create, :scrap_id => @scrap, :link => @link.attributes.slice("url"), :format => :json
    end
 
    assert_response :success
  end
    
  test "teacher should create link" do
    sign_in_teacher
    assert_difference('Link.count') do
      post :create, :scrap_id => @scrap, :link => @link.attributes.slice("url"), :format => :json
    end
 
    assert_response :success
  end
  
  test "guest should not delete link" do
    delete :destroy, :id => @link.to_param, :format => :json
    assert_redirected_to root_url
  end  
   
  test "student should destroy his own link" do
    student = sign_in_student
    link = FactoryGirl.create(:link, :scrap => @scrap, :user => student)
    
    assert_difference('Link.count', -1) do
      delete :destroy, :id => link.to_param, :format => :json
    end
    assert_response :success
  end
  
  test "teacher should destroy student link" do
    student = create_student
    link = FactoryGirl.create(:link, :scrap => @scrap, :user => student)
    sign_in_teacher
    
    assert_difference('Link.count', -1) do
      delete :destroy, :id => link.to_param, :format => :json
    end
    assert_response :success
  end
end
