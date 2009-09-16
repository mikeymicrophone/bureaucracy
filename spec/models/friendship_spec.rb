require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Friendship do
  before do
    @friendship = Friendship.make
  end
  
  describe 'moderating' do
    it 'should be acceptable' do
      @friendship.accept
      @friendship.status.should == 'accepted'
    end
    
    it 'should be rejectable' do
      @friendship.reject
      @friendship.status.should == 'rejected'
    end
  end
end