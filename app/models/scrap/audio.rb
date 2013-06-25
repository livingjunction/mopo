class Scrap::Audio < Asset
  belongs_to :scrap, :counter_cache => :audios_count

  has_attached_file :asset, :styles => {
    :mobile => {
      :format => 'mp3', :convert_options => {
        :output => { :strict => 'experimental' }
      }
    }
  }, :processors => [:ffmpeg]
end