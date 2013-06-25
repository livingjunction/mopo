class Asset < ActiveRecord::Base  
  belongs_to :user
  
  delegate :url, :to => :asset
  attr_accessible :asset

  def as_json(options = {})  
    {
      "id" => id,
      "scrap_id" => scrap_id,
      "name" => asset_file_name,
      "size" => asset_file_size,
      "type" => type
    }.merge(options)
  end
end
