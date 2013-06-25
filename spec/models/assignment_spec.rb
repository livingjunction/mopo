require 'spec_helper'

describe Assignment do
  describe "on init" do
    before(:each) do
      @assignment = Assignment.new(
        :name => "name",
        :description => "description"
      )
    end

    it "is valid with valid attributes" do
      @assignment.should be_valid
    end

    it "is not valid without a name" do
      @assignment.name = nil
      @assignment.should_not be_valid
    end

    it "is not valid without a description" do
      @assignment.description = nil
      @assignment.should_not be_valid
    end
  end

  describe "on save" do
    it "has set proper position" do
      category = FactoryGirl.create(:category)
      assignment = FactoryGirl.build(:assignment, :category => category)
      assignment.position.should == nil
      assignment.save
      assignment.position.should == 1

      assignment2 = FactoryGirl.create(:assignment, :category => category)
      assignment2.position.should == 2

      #different category
      assignment3 = FactoryGirl.create(:assignment)
      assignment3.position.should == 1
    end
  end
end
