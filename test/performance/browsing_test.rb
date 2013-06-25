require 'performance_test_helper'
include Warden::Test::Helpers

class BrowsingTest < ActionDispatch::PerformanceTest
  # Refer to the documentation for all available options
  # self.profile_options = { :runs => 5, :metrics => [:wall_time, :memory]
  #                          :output => 'tmp/performance', :formats => [:flat] }

  def test_homepage
    student = User.find(1)
    login_as(student, :scope => :user)
    get '/'
  end
  
  def test_categorypage
    get '/categories/3'
  end
end
