class ApplicationController < ActionController::Base

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end

  protect_from_forgery

  helper_method :categories, :abilities, :has_unread_notifications, :unread_notifications_counter,
    :ios?, :fb_enabled?, :share_scrap_to_fb?, :twitter_enabled?, :share_scrap_to_twitter?

  def categories
    Category.all
  end

  def abilities
    current_ability.instance_variable_get("@rules").collect{ |rule|
      {
        :base_behavior => rule.instance_variable_get("@base_behavior"),
        :subjects => rule.instance_variable_get("@subjects").map { |s| s.to_s },
        :actions => rule.instance_variable_get("@actions").map { |a| a.to_s },
        :conditions => rule.instance_variable_get("@conditions")
      }
    }
  end

  def has_unread_notifications
    unread_notifications_counter > 0
  end

  def unread_notifications_counter
    current_user.notifications.unread.size
  end

  def notify_about_activity(recipient, trackable, action = params[:action])
    activity = current_user.activities.create! action: action, trackable: trackable
    activity.notify recipient
  end

  def ios?
    request.user_agent =~ /iPhone|iPad|iPod/i
  end

  def fb_enabled?
    return false unless Rails.configuration.secrets.facebook.present?
    Rails.configuration.secrets.facebook.enabled
  end

  def share_scrap_to_fb?(scrap)
    fb_enabled? && scrap.public?
  end

  def twitter_enabled?
    return false unless Rails.configuration.secrets.twitter.present?
    Rails.configuration.secrets.twitter.enabled
  end

  def share_scrap_to_twitter?(scrap)
    twitter_enabled? && scrap.public?
  end
end
