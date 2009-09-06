require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe User do
  before do
    @user = User.make
  end

  it "should create a new instance given valid attributes" do
    @valid_attributes = {
      :login => 'blanket',
      :email => 'biz@example.com',
      :password => 'builderness',
      :password_confirmation => 'builderness'
    }

    u = User.new(@valid_attributes)
    u.should be_valid
  end
  
  describe 'belongings' do
  
    before do
      @belonging = Belonging.make(:user => @user)
      @storage_unit = StorageUnit.make(:user => @user)
      Storage.make(:storage_unit => @storage_unit, :belonging => @belonging)
      @building = Building.make
      @room = Room.make(:building => @building)
      Placement.make(:belonging => @storage_unit.belonging, :room => @room)
    end
  
    it 'should identify its belongings' do
      @user.belongings.should == [@belonging, @storage_unit.belonging]
    end
    
    it 'should know what storage units its belongings are in' do
      @user.storage_storage_units.should == [@storage_unit]
    end
    
    it 'should know what rooms its belongings are in' do
      @user.storage_rooms.should == [@room]
    end
    
    it 'should know what buildings its belongings are in' do
      @user.storage_buildings.should == [@building]
    end
  end
end
