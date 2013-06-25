class Assignment < ActiveRecord::Base
  has_many :projects
  has_many :scraps
  belongs_to :category
  belongs_to :user
  attr_accessible :description, :name

  validates_presence_of :name, :description

  before_save :set_position

  protected

  def set_position
    self.position ||= 1 + (Assignment.where('category_id=?', category_id).maximum(:position) || 0)
  end
end
