class Scrap::Image < Asset
  belongs_to :scrap, :counter_cache => :images_count

  #620 + padding = 640 horizontal
  #340 + padding = 360 vertical
  has_attached_file :asset, :styles => {
    :thumb => "40x40#",
    :portrait => "360x270>",
    :landscape => "640x480>"
  }

  validates_attachment_content_type :asset, :content_type => /image/,
    :message => I18n.t("errors.attributes.scrap_image.asset_content_type")


  def as_json(options = {})
    super({
      "thumb_url" => url(:thumb)
    })
  end

end