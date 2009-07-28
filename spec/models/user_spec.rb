require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe User do
  before(:each) do
    @valid_attributes = {
      :email => 'biz@example.com'
    }
  end

  it "should create a new instance given valid attributes" do
    u = User.new(@valid_attributes)
    u.should be_valid
  end
end
