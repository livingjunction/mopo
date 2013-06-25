class Notification < ActiveRecord::Base
  belongs_to :activity
  belongs_to :user
  attr_accessible :is_read
  
  scope :unread, where(:is_read => false)
  scope :latest, order("is_read asc, id desc")
  
  acts_as_api

  api_accessible :notification do |t| 
    t.add :id
    t.add :is_read
    t.add :activity
  end
end
