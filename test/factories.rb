FactoryGirl.define do
  sequence :email do |n|
    "t#{n}@frosmo.com"
  end

  factory :user do
    email    { generate :email }
    password  "password"
    password_confirmation  { |u| u.password }
    first_name "frst_name"
    last_name "last_name"

    factory :student do
      security_code { Rails.configuration.secrets.user_code.student }
      role "student"

      factory :moomin do
        first_name "Moomin"
        last_name "Troll"
      end

      factory :little_my do
        first_name "Little"
        last_name "My"
      end
    end

    factory :teacher do
      security_code { Rails.configuration.secrets.user_code.teacher }
      role "teacher"

      factory :moominpappa do
        first_name "Moomin"
        last_name "Pappa"
      end
    end
  end

  factory :category do
    sequence(:name) {|n| "Category #{n}" }
  end

  factory :assignment do
    category
    association :user, :factory => :teacher
    name 'Assignment name'
    description 'Assignment desc'
  end

  factory :project do
    association :user, :factory => :student
    assignment
    name "Project name"
  end

  factory :scrap do
    association :user, :factory => :student
    project
    assignment { project.assignment }
    name "Scrap name"
    description "Scrap desc"
    privacy :public

    factory :public_scrap do
      privacy :public
    end

    factory :registered_scrap do
      privacy :registered
    end

    factory :private_scrap do
      privacy :private
    end
  end

  factory :scrap_image, class: "Scrap::Image" do
    association :user, :factory => :student
    scrap
    type "Scrap::Image"
  end

  factory :link do
    association :user, :factory => :student
    scrap
    url "http://mopo.livingjunction.com"
  end

  factory :comment do
    association :user, :factory => :student
    scrap
    body "Comment"
  end

  factory :like do
    association :user, :factory => :student
    scrap
  end

  factory :flag do
    association :user, :factory => :student
    scrap
    color :green
  end

  factory :activity do
    association :user, :factory => :student
    action "create"

    factory :comment_activity do
      association :trackable, :factory => :comment
    end

    factory :flag_activity do
      association :trackable, :factory => :flag
    end
  end

  factory :notification do
    association :user, :factory => :student
    activity
  end
end