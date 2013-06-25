require "spec_helper"

describe ScrapsHelper do
  describe "#scrap_thumb" do
    it "returns nth when no images but images_count > 0" do
      scrap = FactoryGirl.create(:scrap, images_count: 1);
      helper.scrap_thumb(scrap).should be_nil
    end

    it "returns nth when no videos but videos_count > 0" do
      scrap = FactoryGirl.create(:scrap, videos_count: 1);
      helper.scrap_thumb(scrap).should be_nil
    end

    it "returns nth when no links but links_count > 0" do
      scrap = FactoryGirl.create(:scrap, links_count: 1);
      helper.scrap_thumb(scrap).should be_nil
    end
  end

  describe  "#get_youtube_id" do
    it "returns id when 'share' link" do
      url = "http://youtu.be/9pmPa_KxsAM" #google io 2013 keynote
      helper.get_youtube_id(url).should eq("9pmPa_KxsAM")
    end

    it "returns id when 'watch' link" do
      url = "http://www.youtube.com/watch?v=9pmPa_KxsAM"
      helper.get_youtube_id(url).should eq("9pmPa_KxsAM")
    end

    it "returns nil when other link" do
      helper.get_youtube_id("http://www.goole.com").should be_nil
      helper.get_youtube_id("http://www.you.com/abcdefs").should be_nil
      helper.get_youtube_id("http://sth.com/watch?v=9pmPa_KxsAM").should be_nil
    end
  end
end
