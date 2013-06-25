require 'spec_helper'

describe Scrap do
  describe "on init" do
    before(:each) do
      @scrap = Scrap.new(
        :name => "name",
        :description => "description"
      )
    end

    it "is valid with valid attributes" do
      @scrap.should be_valid
    end

    it "is not valid without a name" do
      @scrap.name = nil
      @scrap.should_not be_valid
    end

    it "is not valid without a description" do
      @scrap.description = nil
      @scrap.should_not be_valid
    end
  end

  describe "#select_by_category_id" do
    describe "when no category specified" do
      it "returns scoped scraps" do
        user = FactoryGirl.create(:student)
        user.scraps.select_by_category_id.should == []

        scrap = FactoryGirl.create(:scrap, :user => user)

        user.scraps.select_by_category_id.should == [scrap]
      end
    end

    describe "when empty category specified" do
      it "returns scoped scraps" do
        user = FactoryGirl.create(:student)
        user.scraps.select_by_category_id("").should == []

        scrap = FactoryGirl.create(:scrap, :user => user)

        user.scraps.select_by_category_id("").should == [scrap]
      end
    end

    describe "when category specified" do
      it "returns scoped scraps from category" do
        user = FactoryGirl.create(:student)
        scrap = FactoryGirl.create(:scrap, :user => user)
        scrap2 = FactoryGirl.create(:scrap, :user => user)

        user.scraps.select_by_category_id(0).should == []
        user.scraps.select_by_category_id(scrap.assignment.category_id).should == [scrap]
        user.scraps.select_by_category_id(scrap2.assignment.category_id).should == [scrap2]
      end
    end
  end

  describe "#projects" do
    describe "when assignment" do
      it "returns assignment projects" do
        scrap = FactoryGirl.create(:scrap)
        scrap.projects.should == scrap.assignment.projects
      end
    end
    describe "when project and no assignment" do
      it "returns project" do
        scrap = FactoryGirl.create(:scrap)
        scrap.assignment.destroy
        scrap.projects.should == [scrap.project]
      end
    end
    describe "when no project and noassignment" do
      it "returns array" do
        scrap = Scrap.new
        scrap.projects.should == []
      end
    end
  end

  describe "#public?" do
    it "returns true for public" do
      scrap = FactoryGirl.create(:public_scrap)
      scrap.public?.should be_true
    end
    it "returns false for registered" do
      scrap = FactoryGirl.create(:registered_scrap)
      scrap.public?.should be_false
    end
    it "returns false for private" do
      scrap = FactoryGirl.create(:private_scrap)
      scrap.public?.should be_false
    end
  end

end
