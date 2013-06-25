require 'spec_helper'

describe Link do
  before(:each) do
    @link = Link.new(
      :url => "http://mopo.livingjunction.com"
    )
  end
  
  it "is valid with valid attributes" do
    @link.should be_valid
  end
  
  it "is not valid without a url" do
    @link.url = nil
    @link.should_not be_valid
  end
  
  it "is not valid with wrong url" do
    @link.url = 'abcdef'
    @link.should_not be_valid
  end
end
