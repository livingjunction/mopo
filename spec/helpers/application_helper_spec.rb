require "spec_helper"

describe ApplicationHelper do
  describe "#show_line_breaks" do
    it "returns 1 line break" do
      text = "1\n2"
      helper.show_line_breaks(text).should eq("1<br/>2")
    end
    
    #simple_format changes 2 and more line breaks to <p>
    it "returns 2 line breaks" do
      text = "1\n\n2"
      helper.show_line_breaks(text).should eq("1<br/><br/>2")
    end
    
    it "returns 3 line breaks" do
      text = "1\n\n\n2"
      helper.show_line_breaks(text).should eq("1<br/><br/><br/>2")
    end
    
    it "escapes html tags" do
      text = "<p>1\n2</p>"
      helper.show_line_breaks(text).should eq("&lt;p&gt;1<br/>2&lt;/p&gt;")
    end
    
  end
end
