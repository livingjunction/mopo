class Link < ActiveRecord::Base
  belongs_to :scrap, :counter_cache => true
  belongs_to :user

  attr_accessible :url
  
  before_validation :smart_add_url_protocol
  validates :url, :presence => true, :url => true   

  protected
  
  def smart_add_url_protocol
    unless self.url.blank? || self.url[/^http:\/\//] || self.url[/^https:\/\//]
      self.url = 'http://' + self.url
    end
  end
end
