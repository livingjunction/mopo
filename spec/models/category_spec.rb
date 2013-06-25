require 'spec_helper'

describe Category do

  describe "order by" do
    it "position" do
      category = FactoryGirl.create(:category, :position => 2)
      category2 = FactoryGirl.create(:category, :position => 1)

      categories = Category.all
      categories[0].should == category2
      categories[1].should == category
    end

    it "name when position not defined" do
      category = FactoryGirl.create(:category, :name => "b")
      category2 = FactoryGirl.create(:category, :name => "a")

      categories = Category.all
      categories[0].should == category2
      categories[1].should == category
    end
  end
end
