require 'spec_helper'

describe Project do
  describe "on init" do
    before(:each) do
      @project = Project.new(
        :name => "name"
      )
    end

    it "is valid with valid attributes" do
      @project.should be_valid
    end

    it "is not valid without a name" do
      @project.name = nil
      @project.should_not be_valid
    end
  end

  describe "on destroy" do
    it "nullify project_id in associated scrap" do
      scrap = FactoryGirl.create(:scrap)

      scrap.project.destroy
      scrap.reload
      scrap.should_not be_nil
      scrap.project_id.should be_nil
    end
  end

end
