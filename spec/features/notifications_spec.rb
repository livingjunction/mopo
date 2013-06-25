# encoding: UTF-8
require 'spec_helper'
include Warden::Test::Helpers

describe "Notifications" do
  describe "when on home page " do
    it "shows number of unread notifications and list of all", js: true do
      moomin = FactoryGirl.create(:moomin)
      little_my = FactoryGirl.create(:little_my)
      moominpappa = FactoryGirl.create(:moominpappa)
      scrap = FactoryGirl.create(:scrap, :user => moomin)

      comment = FactoryGirl.create(:comment, :scrap => scrap, :user => little_my)
      comment_activity = FactoryGirl.create(:comment_activity, :user => little_my, :trackable => comment)
      comment_notification = FactoryGirl.create(:notification, :user => moomin, :activity => comment_activity)

      comment2 = FactoryGirl.create(:comment, :scrap => scrap, :user => moominpappa)
      comment2_activity = FactoryGirl.create(:comment_activity,
        :user => moominpappa, :trackable => comment2)
      comment2_notification = FactoryGirl.create(:notification, :user => moomin,
        :activity => comment2_activity, :is_read => true)

      flag = FactoryGirl.create(:flag, :scrap => scrap, :user => moominpappa, :color => "green")
      flag_activity = FactoryGirl.create(:flag_activity, :user => moominpappa, :trackable => flag)
      flag_notification = FactoryGirl.create(:notification, :user => moomin, :activity => flag_activity)
      other_notification = FactoryGirl.create(:notification, :user => little_my)

      login_as(moomin, :scope => :user)

      visit home_path

      #total of 4: 2 good, 1 read, 1 for other user
      find('.user-notifications-link').should have_content('2')
      find('.user-notifications-link').click

      find('#notifications li:nth-child(1)').should have_content(I18n.t("shared.layouts.panel.notifications"))
      find('#notifications li:nth-child(2)').should have_content(
        I18n.t('shared.activities.flag.created', {
          user: "Moomin Pappa",
          color: I18n.t("shared.activities.flag.colors.green"),
          scrap: scrap.name
        })
      )
      find('#notifications li:nth-child(3)').should have_content(
        I18n.t('shared.activities.comment.created', {
          user: "Little My",
          scrap: scrap.name
        })
      )
      find('#notifications li:nth-child(4)').should have_content(
        I18n.t('shared.activities.comment.created', {
          user: "Moomin Pappa",
          scrap: scrap.name
        })
      )
      page.should_not have_content(
        I18n.t('shared.activities.comment.created', {
          user: "Moomin Troll",
          scrap: scrap.name
        })
      )

      find('#notifications li:nth-child(2)').click

      page.should have_css("div.scrap-view")
      find('.ui-page-active .user-notifications-link').should have_content('1')
      find('.ui-page-active .user-notifications-link').click
      find('.ui-page-active #notifications li:nth-child(2)').should have_content(
        I18n.t('shared.activities.comment.created', {
          user: "Little My",
          scrap: scrap.name
        })
      )
      find('.ui-page-active #notifications li:nth-child(3)').should have_content(
        I18n.t('shared.activities.flag.created', {
          user: "Moomin Pappa",
          color: I18n.t("shared.activities.flag.colors.green"),
          scrap: scrap.name
        })
      )
      find('.ui-page-active #notifications li:nth-child(4)').should have_content(
        I18n.t('shared.activities.comment.created', {
          user: "Moomin Pappa",
          scrap: scrap.name
        })
      )

    end
  end
end
