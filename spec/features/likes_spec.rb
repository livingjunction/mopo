# encoding: UTF-8
require 'spec_helper'
include Warden::Test::Helpers

describe "Likes" do
  describe "GET scrap page" do
    before :each do
      student = FactoryGirl.create(:student)
      login_as(student, :scope => :user)

      @project = FactoryGirl.create(:project)
      @scrap = FactoryGirl.create(:scrap, :project => @project)
    end

    it "displays number of likes, adds and removes like", :js => true do
      visit scrap_path(@scrap)

      page.should have_content(I18n.t("shared.likes.counts", {count: 0}))
      click_link('like-scrap')
      page.should have_content(I18n.t("shared.likes.counts", {count: 1}))
      click_link('like-scrap')
      page.should have_content(I18n.t("shared.likes.counts", {count: 0}))
    end
  end
end
