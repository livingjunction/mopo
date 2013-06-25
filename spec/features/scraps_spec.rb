# encoding: UTF-8
require 'spec_helper'
include Warden::Test::Helpers

describe "Scraps" do
  describe "when on SHOW scrap page" do
    it "displays user, scrap name and description and removes", :js => true do
      user = FactoryGirl.create(:student, :first_name => "first", :last_name => "last")
      project = FactoryGirl.create(:project)
      scrap = FactoryGirl.create(:scrap, :project => project, :name => "scrap name",
        :description => "Lorem ipsum", :user => user)
      image = Scrap::Image.new :asset => File.new(Rails.root + 'spec/fixtures/boats.jpg')
      image.scrap = scrap
      image.save
      link = FactoryGirl.create(:link, :scrap => scrap, :url => "http://livingjunction.com")
      login_as(user, :scope => :user)

      visit scrap_path(scrap)

      page.should have_content("first last")
      page.should have_content("scrap name")
      page.should have_content("Lorem ipsum")
      page.should have_image 'boats.jpg'
      page.should have_css("a[href='http://livingjunction.com']")

      find(".delete-scrap").click
      page.should have_content(I18n.t('shared.delete'))
      click_on(I18n.t('shared.delete'))
      page.should have_content(I18n.t('projects.show.scraps_header'))
    end
  end

  describe "when on home page with scraps" do
    it "fetches more scraps when scrolling to bottom", js: true do
      project = FactoryGirl.create(:project)
      student = FactoryGirl.create(:student)
      login_as(student, :scope => :user)
      11.times {
        |n| FactoryGirl.create(
          :scrap,
          :user => student,
          :project => project,
          :name => "Scrap name ##{n+1}#",
          :description => "Scrap desc ##{n+1}# Lorem ipsum dolor sit amet,
            consectetur adipiscing elit. Sed facilisis nisl et mauris venenatis
            sed eleifend diam scelerisque. Suspendisse mattis scelerisque ligula,
            vitae auctor nisl hendrerit vel. Morbi semper varius leo ac molestie."
        )
      }

      visit home_path
      page.should have_content('Scrap name #11#')
      page.should have_content('Scrap desc #11#')
      page.should_not have_content('Scrap name #1#')
      page.evaluate_script("window.scrollTo(0, document.height)")
      page.should have_content('Scrap name #1#')
      page.should have_content('Scrap desc #1#')
    end
  end

  describe "when on NEW scrap page" do
    describe "when invalid data" do
      it "shows error message", :js => true do
        student = FactoryGirl.create(:student)
        login_as(student, :scope => :user)
        @assignment = FactoryGirl.create(:assignment)
        @project = FactoryGirl.create(:project, :user => student, :assignment => @assignment)

        visit new_project_scrap_path(@project)

        find_field('scrap_name').value.empty?
        find_field('scrap_description').value.empty?

        click_button "submit_scrap"

        #same page
        page.should have_css('div#new-edit-scrap-view')
        page.should have_css('.field_with_errors', :count => 2)
        page.should have_content(I18n.t('errors.messages.blank'))
      end
    end

    describe "when valid data" do
      before :each do
        student = FactoryGirl.create(:student)
        login_as(student, :scope => :user)
        @assignment = FactoryGirl.create(:assignment)
        @project = FactoryGirl.create(:project, :user => student, :name => "Pn1",
          :assignment => @assignment)
        project2 = FactoryGirl.create(:project, :user => student, :name => "Pn2",
          :assignment => @assignment)
        project3 = FactoryGirl.create(:project, :user => student, :name => "Pn3")
      end

      it "creates scrap with image and link, when project defined", :js => true do
        filename = 'boats.jpg'
        filepath = "spec/fixtures/#{filename}"

        visit new_project_scrap_path(@project)

        page.should have_select("scrap_project_id", :selected => "Pn1",
          :options => ["Pn1", "Pn2"])
        select "Pn2", :from => "scrap_project_id"
        find_field('scrap_name').value.empty?
        fill_in "scrap_name", :with => "Scrap name"
        find_field('scrap_description').value.empty?
        fill_in "scrap_description", :with => "Scrap desc"
        find("#new_link").should_not be_visible
        find("#media_link").click
        find("#new_link").should be_visible
        within("#new_link") do
          fill_in "link_url", :with => "http://livingjunction.com"
          click_button("add_link")
        end
        page.should have_content('http://livingjunction.com')
        attach_file 'scrap_image_asset', File.expand_path(filepath)

        click_button "submit_scrap"

        page.should have_css('div.scrap-view')
        page.should have_content('Pn2')
        page.should have_content('Scrap name')
        page.should have_content('Scrap desc')
        page.should have_image filename
        page.should have_css('a[href="http://livingjunction.com"]')
      end

      it "creates scrap with image and link, when assignment defined", :js => true do
        filename = 'boats.jpg'
        filepath = "spec/fixtures/#{filename}"

        visit new_assignment_scrap_path(@assignment)

        page.should have_select("scrap_project_id",
          :options => [I18n.t('projects.select_prompt'), "Pn1", "Pn2"])
        find_field('scrap_name').value.empty?
        fill_in "scrap_name", :with => "Scrap name"
        find_field('scrap_description').value.empty?
        fill_in "scrap_description", :with => "Scrap desc"
        find("#new_link").should_not be_visible
        find("#media_link").click
        find("#new_link").should be_visible
        within("#new_link") do
          fill_in "link_url", :with => "http://livingjunction.com"
          click_button("add_link")
        end
        page.should have_content('http://livingjunction.com')
        attach_file 'scrap_image_asset', File.expand_path(filepath)

        click_button "submit_scrap"

        page.should have_css('div.scrap-view')
        page.should have_content('Scrap name')
        page.should have_content('Scrap desc')
        page.should have_image filename
        page.should have_css('a[href="http://livingjunction.com"]')
      end
    end
  end

  describe "when on EDIT scrap page" do
    describe "when invalid data" do
      it "shows error message", :js => true do
        student = FactoryGirl.create(:student)
        login_as(student, :scope => :user)
        @project = FactoryGirl.create(:project, :user => student)
        @scrap = FactoryGirl.create(:scrap, :user => student,
          :project => @project, :name => "Edit name", :description => "Edit desc")

        visit edit_scrap_path(@scrap)

        fill_in "scrap_name", :with => ""
        fill_in "scrap_description", :with => ""

        click_button "submit_scrap"

        #same page
        page.should have_css('div#new-edit-scrap-view')
        page.should have_css('.field_with_errors', :count => 2)
        page.should have_content(I18n.t('errors.messages.blank'))
      end
    end

    describe "when valid data" do
      before :each do
        student = FactoryGirl.create(:student)
        login_as(student, :scope => :user)
        @project = FactoryGirl.create(:project, :user => student)
        @scrap = FactoryGirl.create(:scrap, :user => student,
          :project => @project, :name => "Edit name", :description => "Edit desc")
      end

      it "updates scrap with new image and new link", :js => true do
        filename = 'boats.jpg'
        filepath = "spec/fixtures/#{filename}"
        visit edit_scrap_path(@scrap)

        find_field('scrap_name').value.should eq("Edit name")
        fill_in "scrap_name", :with => "New edit name"
        find_field('scrap_description').should have_content("Edit desc")
        fill_in "scrap_description", :with => "New edit desc"
        page.should have_no_content(filename)
        attach_file 'scrap_image_asset', File.expand_path(filepath)
        find("#new_link").should_not be_visible
        find("#media_link").click
        find("#new_link").should be_visible
        within("#new_link") do
          fill_in "link_url", :with => "http://livingjunction.com"
          click_button("add_link")
        end
        page.should have_content('http://livingjunction.com')

        click_button "submit_scrap"

        # important to have_css here, as it poll repeatedly until the condition is true
        # @see http://techblog.fundinggates.com/blog/2012/08/capybara-2-0-upgrade-guide/
        page.should have_css('div.scrap-view')
        #test if it updated same scrap, not created new one
        current_path.should eq(scrap_path(@scrap))
        page.should have_content('New edit name')
        page.should have_content('New edit desc')
        page.should have_image filename
        page.should have_css('a[href="http://livingjunction.com"]')
      end
    end
  end

end
