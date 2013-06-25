ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase

  def create_student
    FactoryGirl.create(:student)    
  end
  
  def create_teacher    
    FactoryGirl.create(:teacher)
  end
  
  def sign_in_student
    student = create_student
    sign_in :user, student
    student
  end
  
  def sign_in_teacher
    teacher = create_teacher
    sign_in :user, teacher
    teacher
  end
  
end

class ActionController::TestCase
  include Devise::TestHelpers
end