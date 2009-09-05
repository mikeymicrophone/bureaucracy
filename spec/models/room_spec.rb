require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Room do
  
  before do
    @storage_unit = StorageUnit.make
    @room = Room.make
    @belonging = Placement.make(:room => @room).belonging
    @stored_belonging = Storage.make(:storage_unit => @storage_unit).belonging
    Placement.make(:room => @room, :belonging => @storage_unit.belonging)    
  end
  
  it 'should know which storage units are in it' do
    @room.storage_units.should == [@storage_unit]
  end
  
  it 'should know what belongings are in its storage units' do
    @room.stored_belongings.should == @room.storage_units.map(&:belongings).flatten
  end
  
  it 'should know which belongings are placed in the room' do
    @room.placed_belongings.sort_by(&:id).should == [@belonging, @storage_unit.belonging].sort_by(&:id)
  end
  
  it 'should count both standalone belongings and those in storage units' do
    @room.belongings.sort_by(&:id).should == [@belonging, @storage_unit.belonging, @stored_belonging].sort_by(&:id)
  end
  
end