# encoding: UTF-8
require 'spec_helper'
include Warden::Test::Helpers

describe "Flags" do
  describe "GET scrap page" do
    before :each do
      teacher = FactoryGirl.create(:teacher)
      login_as(teacher, :scope => :user)

      @project = FactoryGirl.create(:project)
      @scrap = FactoryGirl.create(:scrap, :project => @project)
    end

    it "displays empty flags", :js => true do
      visit scrap_path(@scrap)

      page.should have_selector('.scrap-flag', :count => 3)
      page.should_not have_selector('.selected')
    end

    it "sets green flag, changes it to red and removes it", :js => true do
      visit scrap_path(@scrap)

      find('.scrap-flag-green').click
      page.should have_selector('.scrap-flag-green.selected')

      find('.scrap-flag-red').click
      page.should have_selector('.scrap-flag-red.selected')
      page.should_not have_selector('.scrap-flag-green.selected')

      find('.scrap-flag-red').click
      page.should_not have_selector('.scrap-flag-red.selected')
      page.should_not have_selector('.scrap-flag-green.selected')
    end
  end
end
