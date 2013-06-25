# encoding: UTF-8
require 'spec_helper'
include Warden::Test::Helpers

describe "Assets" do
  describe "when on EDIT scrap page" do
    before :each do
      student = FactoryGirl.create(:student)
      login_as(student, :scope => :user)
      @project = FactoryGirl.create(:project, :user => student)
      @scrap = FactoryGirl.create(:scrap, :user => student,
        :project => @project, :description => "Edit desc")
      @image = Scrap::Image.new(:asset => File.new(Rails.root + 'spec/fixtures/boats.jpg'))
      @image.scrap = @scrap
      @image.save
    end

    it "shows assets", :js => true do
      visit edit_scrap_path(@scrap)

      page.should have_content('boats.jpg')
    end

    it "removes asset", :js => true do
      visit edit_scrap_path(@scrap)

      page.should have_content('boats.jpg')
      find(".delete-asset").click
      page.should have_content(I18n.t('shared.accept'))
      click_on('Ok')
      page.should_not have_content('boats.jpg')
    end
  end

end
