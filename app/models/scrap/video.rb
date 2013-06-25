class Scrap::Video < Asset
  belongs_to :scrap, :counter_cache => :videos_count

  # uses ffmpeg to convert video
  # @see http://ffmpeg.org/trac/ffmpeg/wiki/AACEncodingGuide for strict experimental
  has_attached_file :asset, :styles => {
    :mobile => {
      :geometry => "480x360", :format => 'mp4', :convert_options => {
        :output => { :strict => 'experimental' }
      }
    },
    :poster => { :geometry => "480x360", :format => 'jpg', :time => 1 },
    :thumb => { :geometry => "40x40#", :format => 'jpg', :time => 1 }
  }, :processors => [:ffmpeg]


  def as_json(options = {})
    super({
      "thumb_url" => url(:thumb)
    })
  end

end