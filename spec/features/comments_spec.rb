# encoding: UTF-8
require 'spec_helper'
include Warden::Test::Helpers

describe "Comments" do
  describe "GET scrap page" do
    before :each do
      student = FactoryGirl.create(:student)
      login_as(student, :scope => :user)

      @project = FactoryGirl.create(:project)
      @scrap = FactoryGirl.create(:scrap, :project => @project)
      @comment = FactoryGirl.create(:comment, :scrap => @scrap, :body => "Nice", :user => student)
    end

    it "displays comments, adds and removes comment", :js => true do
      visit scrap_path(@scrap)

      #displays
      page.should have_content("Nice")

      #adds
      fill_in "comment_body", :with => "Great"
      click_button "add_comment"
      page.should have_content("Great")
      page.should have_content("Nice")

      #removes
      first('.delete-comment').click
      page.should have_content(I18n.t('shared.accept'))
      click_on('Ok')
      page.should_not have_content("Nice")
    end

    it "adds emoticon", :js => true do
      visit scrap_path(@scrap)

      fill_in "comment_body", :with => "Smile "
      find('#emoticonsPopupLink').click
      page.should have_content(":) :-D ;-) :-*")
      first('#emoticonsPopup span').click  #:)
      click_button "add_comment"
      page.should have_content("Smile :)")
    end
  end
end
