class Category < ActiveRecord::Base
  has_many :assignments
  has_many :scraps, :through => :assignments
  attr_accessible :name

  default_scope order('position asc, name asc')
end
