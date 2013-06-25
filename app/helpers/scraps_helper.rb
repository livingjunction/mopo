module ScrapsHelper
  def scrap_thumb(scrap)
    if !scrap.images.empty? && scrap.images.first.present?
      return link_to image_tag(scrap.images.first.url(:portrait)), scrap_path(scrap),
        :class => "scrap-thumbnail-image"
    end
    if !scrap.videos.empty? && scrap.videos.first.present?
      return render :partial => "shared/scrap_thumb_video", :locals => {:scrap => scrap}
    end
    if !scrap.links.empty? && scrap.links.first.present?
      return render :partial => "shared/scrap_link", :locals => {
        :link => scrap.links.first,
        :css_class => "scrap-thumbnail-link"
      }
    end
  end

  def get_youtube_id(url)
    if url[/^(https?:\/\/)?(www\.)?youtube.com\/watch\?v=([\w\-]+)/]
      youtube_id = $3
    elsif url[/^(https?:\/\/)?(www\.)?youtu.be\/([\w\-]+)/]
      youtube_id = $3
    end
    youtube_id
  end
end
