# encoding: UTF-8
require 'spec_helper'

describe "signing up" do
  it "with correct data" do
    visit new_user_registration_path
    within("#new_user") do
      fill_in 'user_first_name', :with => 'Little'
      fill_in 'user_last_name', :with => 'My'
      fill_in 'user_email', :with => 't1@frosmo.com'
      fill_in 'user_security_code', :with => Rails.configuration.secrets.user_code.student
      fill_in 'user_password', :with => 'qwerty'
      fill_in 'user_password_confirmation', :with => 'qwerty'
    end
    find('input[type="submit"]').click

    page.should have_content I18n.t("home.index.header")
  end
end
