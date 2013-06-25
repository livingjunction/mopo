require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test 'should require first name to be set' do
    user = User.new(:first_name => nil)
    assert user.invalid?
    assert user.errors[:first_name]
  end
  
  test 'should require last name to be set' do
    user = User.new(:last_name => nil)
    assert user.invalid?
    assert user.errors[:last_name]
  end
    
  test 'should require security code when creating' do
    user = User.new(:security_code => nil)
    assert user.invalid?
    assert user.errors[:security_code]
  end
    
  test 'should require correct security code when creating' do
    user = User.new(:security_code => "aaa")
    assert user.invalid?
    assert user.errors[:security_code]
    assert_equal 'is not valid', user.errors[:security_code].join
  end
  
  test 'should test proper role' do
    teacher = create_teacher
    student = create_student
    
    assert teacher.teacher?
    assert !teacher.student?

    assert student.student?
    assert !student.teacher?
  end
end
