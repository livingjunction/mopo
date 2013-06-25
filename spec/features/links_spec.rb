# encoding: UTF-8
require 'spec_helper'
include Warden::Test::Helpers

describe "Links" do
  describe "when on GET scrap page" do
    before :each do
      student = FactoryGirl.create(:student)
      login_as(student, :scope => :user)

      @project = FactoryGirl.create(:project)
      @scrap = FactoryGirl.create(:scrap, :project => @project)
      @link = FactoryGirl.create(:link, :scrap => @scrap,
        :url => "http://livingjunction.com", :user => student)
    end

    it "displays links" do
      visit scrap_path(@scrap)

      page.should have_css("a[href='http://livingjunction.com']")
    end
  end

  describe "when on EDIT scrap page" do
    before :each do
      student = FactoryGirl.create(:student)
      login_as(student, :scope => :user)
      @project = FactoryGirl.create(:project, :user => student)
      @scrap = FactoryGirl.create(:scrap, :user => student,
        :project => @project)
      @link = FactoryGirl.create(:link, :scrap => @scrap,
        :url => "http://livingjunction.com", :user => student)
    end

    it "shows error when wrong url", :js => true do
      visit edit_scrap_path(@scrap)

      find("#new_link").should_not be_visible
      find("#media_link").click
      within("#new_link") do
        fill_in "link_url", :with => "wrong"
        click_button("add_link")
      end

      page.should have_content(I18n.t('errors.attributes.url.invalid'))
    end

    it "shows and removes link", :js => true do
      visit edit_scrap_path(@scrap)

      page.should have_content("http://livingjunction.com")
      find(".delete-link").click
      page.should have_content(I18n.t('shared.accept'))
      click_on('Ok')
      page.should_not have_content("http://livingjunction.com")
    end
  end
end
