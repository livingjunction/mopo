# encoding: UTF-8
require 'spec_helper'
include Warden::Test::Helpers

describe "Users" do
  describe "when on profile page" do
    it "shows scraps for given category", js: true do
      student = FactoryGirl.create(:student)
      login_as(student, :scope => :user)
      scraps = []
      2.times {
        |n| scraps[n] = FactoryGirl.create(
          :scrap,
          :user => student,
          :name => "Scrap name ##{n+1}#"
        )
      }

      visit user_path(student)

      page.should have_content('Scrap name #1#')
      page.should have_content('Scrap name #2#')

      select scraps[0].assignment.category.name, :from => "category_id"

      page.should_not have_content('Scrap name #2#')
    end
  end

end
