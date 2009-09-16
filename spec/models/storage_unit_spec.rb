require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe StorageUnit do
  it 'should create a belonging during creation' do
    mock.proxy(Belonging).find(:first, anything)
    mock.proxy(Belonging).new
    StorageUnit.create StorageUnit.plan
  end
  
  it 'should know what room it is in' do
    @storage_unit = StorageUnit.make
    @room = Room.make
    Placement.make(:belonging => @storage_unit.belonging, :room => @room)
    @storage_unit.room.should == @room
  end
end