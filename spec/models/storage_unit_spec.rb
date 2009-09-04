require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe StorageUnit do
  it 'should create a belonging during creation' do
    s = StorageUnit.new StorageUnit.plan
    mock(Belonging).create(anything)
    s.save
  end
end