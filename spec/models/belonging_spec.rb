require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Belonging do
  
  before do
    @belonging = Belonging.make
    @building = Building.make
    @room = Room.make(:building => @building)
  end
  
  it 'should be able to be placed in a room' do
    @belonging.place_in(@room)
    @belonging.room.should == @room
  end
  
  context 'in a room' do
    
    before do
      Placement.make(:belonging => @belonging, :room => @room)
    end
    
    it 'should know what building it is in' do
      @belonging.building.should == @building
    end
  end
  
  context 'in a storage unit' do
    
    before do
      @storage_unit = StorageUnit.make
      Storage.create(:storage_unit => @storage_unit, :belonging => @belonging)
      Placement.make(:belonging => @storage_unit.belonging, :room => @room)
    end
    
    it 'should know what unit it is stored in' do
      @belonging.storage_units.should == [@storage_unit]
    end
    
    it 'should know what room it is in' do
      mock.proxy(@belonging).placements
      mock.proxy(@belonging).storage_units
      @belonging.room.should == @room
    end
    
    it 'should know what building it is in' do
      @belonging.building.should == @building
    end
  end
end