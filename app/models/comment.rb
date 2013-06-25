class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :scrap, :counter_cache => true
  attr_accessible :body
  
  acts_as_api

  api_accessible :notification do |t| 
    t.add :scrap_id
    t.add lambda{|comment| comment.scrap.name  }, :as => :scrap_name
    t.add :body
  end
    
  
  def as_json(options = {})
    super(options.merge(:include => { 
      :user => {
        :methods => [ :full_name, :avatar_thumb_url ],
        :only => [ :id ] 
      }
    }))
  end
  
end
