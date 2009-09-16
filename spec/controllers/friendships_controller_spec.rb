require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe FriendshipsController do
  include Authlogic::TestCase
  setup :activate_authlogic

  def mock_friendship(stubs={})
    @mock_friendship ||= mock_model(Friendship, stubs)
  end
  
  before do
    UserSession.create(@current_user = User.make)
  end
  
  describe 'pending' do
    it 'should display pending friend requests' do
      Friendship.make(:user => User.make, :friend => @current_user)
      Friendship.make(:user => User.make, :friend => @current_user)
      get :pending
      assigns[:friendships].length.should == 2
    end
  end

  describe "responding to GET index" do

    it "should expose all friendships as @friendships" do
      mock(Friendship).find(:all){[mock_friendship]}
      get :index
      assigns[:friendships].should == [mock_friendship]
    end

    describe "with mime type of xml" do
  
      it "should render all friendships as xml" do
        request.env["HTTP_ACCEPT"] = "application/xml"
        friendships = []
        mock(Friendship).find(:all){friendships}
        mock(friendships).to_xml(){"generated XML"}
        get :index
        response.body.should == "generated XML"
      end
    
    end

  end

  describe "responding to GET show" do

    it "should expose the requested friendship as @friendship" do
      mock(Friendship).find("37"){mock_friendship}
      get :show, :id => "37"
      assigns[:friendship].should equal(mock_friendship)
    end
    
    describe "with mime type of xml" do

      it "should render the requested friendship as xml" do
        request.env["HTTP_ACCEPT"] = "application/xml"
        mock(Friendship).find("37"){mock_friendship}
        mock(mock_friendship).to_xml{"generated XML"}
        get :show, :id => "37"
        response.body.should == "generated XML"
      end

    end
    
  end

  describe "responding to GET new" do
  
    it "should expose a new friendship as @friendship" do
      #We need to call new before any mocking
      mock_friendship
      mock(Friendship).new{mock_friendship}
      get :new
      assigns[:friendship].should equal(mock_friendship)
    end

  end

  describe "responding to GET edit" do
  
    it "should expose the requested friendship as @friendship" do
      mock(Friendship).find("37"){mock_friendship}
      get :edit, :id => "37"
      assigns[:friendship].should equal(mock_friendship)
    end

  end

  describe "responding to POST create" do

    describe "with valid params" do
      
      it "should expose a newly created friendship as @friendship" do
        friendship = mock_friendship(:save => true)
        mock(Friendship).new({'these' => 'params', 'user_id' => 1}){friendship}
        post :create, :friendship => {:these => 'params'}
        assigns(:friendship).should equal(mock_friendship)
      end

      it "should redirect to the created friendship" do
        friendship = mock_friendship(:save => true)
        stub(Friendship).new{friendship}
        post :create, :friendship => {}
        response.should redirect_to(friendship_url(mock_friendship))
      end
      
    end
    
    describe "with invalid params" do

      it "should expose a newly created but unsaved friendship as @friendship" do
        friendship = mock_friendship(:save => false)
        stub(Friendship).new({'these' => 'params', 'user_id' => 1}){friendship}
        post :create, :friendship => {:these => 'params'}
        assigns(:friendship).should equal(mock_friendship)
      end

      it "should re-render the 'new' template" do
        friendship = mock_friendship(:save => false)
        stub(Friendship).new{friendship}
        post :create, :friendship => {}
        response.should render_template('new')
      end
      
    end
    
  end

  describe "responding to PUT update" do

    describe "with valid params" do

      it "should update the requested friendship" do
        mock(Friendship).find("37"){mock_friendship}
        mock(mock_friendship).update_attributes({'these' => 'params'})
        put :update, :id => "37", :friendship => {:these => 'params'}
      end

      it "should expose the requested friendship as @friendship" do
        stub(Friendship).find{mock_friendship(:update_attributes => true)}
        put :update, :id => "1"
        assigns(:friendship).should equal(mock_friendship)
      end

      it "should redirect to the friendship" do
        stub(Friendship).find{mock_friendship(:update_attributes => true)}
        put :update, :id => "1"
        response.should redirect_to(friendship_url(mock_friendship))
      end

    end
    
    describe "with invalid params" do

      it "should update the requested friendship" do
        mock(Friendship).find("37"){mock_friendship}
        mock(mock_friendship).update_attributes({'these' => 'params'})
        put :update, :id => "37", :friendship => {:these => 'params'}
      end

      it "should expose the friendship as @friendship" do
        stub(Friendship).find{mock_friendship(:update_attributes => false)}
        put :update, :id => "1"
        assigns(:friendship).should equal(mock_friendship)
      end

      it "should re-render the 'edit' template" do
        stub(Friendship).find{mock_friendship(:update_attributes => false)}
        put :update, :id => "1"
        response.should render_template('edit')
      end

    end

  end

  describe "responding to DELETE destroy" do

    it "should destroy the requested friendship" do
      mock(Friendship).find("37"){mock_friendship}
      mock(mock_friendship).destroy
      delete :destroy, :id => "37"
    end
  
    it "should redirect to the friendships list" do
      stub(Friendship).find(){mock_friendship(:destroy => true)}
      delete :destroy, :id => "1"
      response.should redirect_to(friendships_url)
    end

  end

end
