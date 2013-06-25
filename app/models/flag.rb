class Flag < ActiveRecord::Base
  belongs_to :user
  belongs_to :scrap
  attr_accessible :color
  
  validates_columns :color
  
  acts_as_api

  api_accessible :notification do |t| 
    t.add :scrap_id
    t.add lambda{|flag| flag.scrap.name  }, :as => :scrap_name
    t.add :color
  end
  
end
