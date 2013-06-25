class Activity < ActiveRecord::Base
  belongs_to :user
  belongs_to :trackable, polymorphic: true
  has_many :notifications
  
  attr_accessible :action, :trackable

  acts_as_api

  api_accessible :notification do |t| 
    t.add lambda{|activity| activity.user.full_name  }, :as => :user_full_name
    t.add :action
    t.add lambda{|activity| activity.trackable_type.downcase  }, :as => :trackable_type
    t.add :trackable
    t.add :created_at
  end
    
  def notify(user)
    if self.user != user
      notification = self.notifications.build 
      notification.user = user
      notification.save
    end
  end
end
