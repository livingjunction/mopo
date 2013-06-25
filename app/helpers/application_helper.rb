module ApplicationHelper
  
  def button_new(name, url, options = {})
    default = {
      "data-role" => "button",  
      "data-icon" => "plus",
      "data-theme" => "e"
    }
    link_to name, url, default.merge(options)
  end
  
  def button_edit(url, options = {})
    default = {
      "data-role" => "button",  
      "data-iconpos" => "notext", 
      "data-icon" => "edit",
      "data-mini" => "true", 
      "data-inline" => "true"
    }
    link_to t("shared.edit"), url, default.merge(options)
  end
  
  def button_delete(url, object, confirmation)
    render :partial => "shared/button_delete_with_confirmation", 
      :locals => {:url => url, :object => object, :confirmation => confirmation}
  end
  
  def button_selector(name, url, options = {})
    default = {
      "data-role" => "button",  
      "data-transition" => "slide", 
      "data-icon" => "arrow-r",
      "data-iconpos" => "right" 
    }
    link_to name, url, default.merge(options)
  end
  
  def current_user_id
    current_user.id if current_user
  end

  def show_line_breaks(content)
    h(content).gsub(/\n/, '<br/>').html_safe
  end
end
