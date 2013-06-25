class Project < ActiveRecord::Base
  has_many :scraps, :dependent => :nullify
  belongs_to :assignment
  belongs_to :user
  attr_accessible :name

  validates_presence_of :name
end
