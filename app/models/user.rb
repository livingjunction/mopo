class User < ActiveRecord::Base
  has_many :assignments
  has_many :scraps
  has_many :assets
  has_many :likes
  has_many :liked_scraps, :through => :likes, :class_name => :scraps, :uniq => true
  has_many :flags
  has_many :links
  has_many :activities
  has_many :notifications

  has_attached_file :avatar, :styles => { :medium => "200x200>", :thumb => "40x40#" },
    :default_url => '/images/user-square.png'

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable,
         :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation,
    :first_name, :last_name, :security_code, :avatar
  attr_accessor :security_code

  validates_presence_of :first_name, :last_name
  validates_presence_of :security_code, :on => :create
  validate :correct_security_code, :on => :create

  before_create :set_role

  after_initialize :default_values

  self.per_page = 30

  def full_name
    "#{first_name} #{last_name}"
  end

  def avatar_thumb_url
    avatar.url(:thumb)
  end

  def teacher?
    role == :teacher
  end

  def student?
    role == :student
  end

  def security_code_enabled?
    config_user_code.enable
  end

  def self.search(search = nil)
    return scoped unless search.present?
    where('first_name LIKE ? OR last_name LIKE ?', "%#{search}%", "%#{search}%")
  end

  protected
  def config_user_code
    Rails.configuration.secrets.user_code
  end

  def correct_security_code
    errors.add(:security_code, "is not valid") if security_code != config_user_code.student and
      security_code != config_user_code.teacher
  end

  def set_role
    if self.security_code == config_user_code.student
      self.role = :student
    elsif security_code == config_user_code.teacher
      self.role = :teacher
    end
  end

  def default_values
    self.security_code ||= config_user_code.teacher unless security_code_enabled?
  end
end
