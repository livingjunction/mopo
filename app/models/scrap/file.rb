class Scrap::File < Asset
  belongs_to :scrap, :counter_cache => :files_count
  
  has_attached_file :asset
end