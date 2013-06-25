require 'spec_helper'

describe Activity do  
  describe "notify" do
    it "creates notification" do
      little_my = FactoryGirl.create(:little_my)
      moomin = FactoryGirl.create(:moomin)
      activity = FactoryGirl.create(:comment_activity, user: little_my)
      
      Notification.count.should eq(0)
      activity.notify(moomin)
      Notification.count.should eq(1)
    end
    
    it "does not create notification for owner" do
      little_my = FactoryGirl.create(:little_my)
      moomin = FactoryGirl.create(:moomin)
      activity = FactoryGirl.create(:comment_activity, user: little_my)
      
      Notification.count.should eq(0)
      activity.notify(little_my)
      Notification.count.should eq(0)
    end
  end
  
end
