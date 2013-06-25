require 'spec_helper'

describe User do
  describe "#search" do
    describe "when no search specified" do
      it "returns scoped" do
        User.search.should == []
        user = FactoryGirl.create(:student)

        User.search.should == [user]
      end
    end

    describe "when empty search specified" do
      it "returns scoped" do
        User.search("").should == []
        user = FactoryGirl.create(:student)

        User.search("").should == [user]
      end
    end

    describe "when search specified" do
      it "returns user who match first or last name" do
        user1 = FactoryGirl.create(:student, :first_name => "firstooo", :last_name => "sth")
        user2 = FactoryGirl.create(:teacher, :first_name => "sth", :last_name => "lastooo")
        user3 = FactoryGirl.create(:teacher, :first_name => "sth", :last_name => "sth")

        User.search("ooo").should == [user1, user2]
        User.search("nothinig").should == []
      end
    end
  end
end