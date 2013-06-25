class Scrap < ActiveRecord::Base
  attr_accessible :name, :description, :privacy, :project_id, :assignment_id,
    :videos_attributes, :images_attributes, :audios_attributes, :files_attributes
  belongs_to :project
  belongs_to :assignment
  belongs_to :user
  has_many :assets
  has_many :videos, :class_name => "Scrap::Video", :dependent => :destroy
  has_many :images, :class_name => "Scrap::Image", :dependent => :destroy
  has_many :audios, :class_name => "Scrap::Audio", :dependent => :destroy
  has_many :files, :class_name => "Scrap::File", :dependent => :destroy
  has_many :comments, :dependent => :destroy
  has_many :likes, :dependent => :destroy
  has_many :likers, :through => :scraps, :class_name => :user, :uniq => true
  has_one :flag, :dependent => :destroy
  has_many :links, :dependent => :destroy


  scope :latest, order('id DESC')

  validates_presence_of :name, :description
  validates_columns :privacy

  after_initialize :default_values

  def self.select_by_category_id(category_id = nil)
    return scoped unless category_id.present?
    joins(:assignment => :category).where("categories.id=?", category_id)
  end

  def projects
    if self.assignment
      projects = self.assignment.projects
    elsif self.project
      projects = [self.project]
    else
      projects = []
    end
    projects
  end

  def public?
    privacy == :public
  end

  private
  def default_values
    self.privacy||= :public
  end
end
