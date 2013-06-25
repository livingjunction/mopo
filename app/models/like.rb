class Like < ActiveRecord::Base
  belongs_to :scrap, :counter_cache => true
  belongs_to :user

  attr_accessible :scrap, :user
end
