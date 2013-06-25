# encoding: UTF-8
require 'spec_helper'

describe "signing in" do
  it "with correct credentials" do
    user = FactoryGirl.create(:student, :email => "t1@frosmo.com", :password => "qwerty")

    visit new_user_session_path
    within("#new_user") do
      fill_in 'user_email', :with => 't1@frosmo.com'
      fill_in 'user_password', :with => 'qwerty'
    end
    find('input[type="submit"]').click

    page.should have_content I18n.t("home.index.header")
  end

  it "with wrong credentials" do
    user = FactoryGirl.create(:student, :email => "t1@frosmo.com", :password => "qwerty")

    visit new_user_session_path
    within("#new_user") do
      fill_in 'user_email', :with => 't1@frosmo.com'
      fill_in 'user_password', :with => 'aabbcc'
    end
    find('input[type="submit"]').click

    page.should have_content I18n.t('devise.failure.invalid')
  end
end
