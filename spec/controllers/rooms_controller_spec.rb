require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe RoomsController do
  include Authlogic::TestCase
  setup :activate_authlogic

  def mock_room(stubs={})
    @mock_room ||= mock_model(Room, stubs)
  end

  before do
    UserSession.create User.make
  end
  
  describe "responding to GET index" do

    it "should expose all rooms as @rooms" do
      mock(Room).find(:all){[mock_room]}
      get :index
      assigns[:rooms].should == [mock_room]
    end

    describe "with mime type of xml" do
  
      it "should render all rooms as xml" do
        request.env["HTTP_ACCEPT"] = "application/xml"
        rooms = []
        mock(Room).find(:all){rooms}
        mock(rooms).to_xml(){"generated XML"}
        get :index
        response.body.should == "generated XML"
      end
    
    end

  end

  describe "responding to GET show" do

    it "should expose the requested room as @room" do
      mock(Room).find("37"){mock_room}
      get :show, :id => "37"
      assigns[:room].should equal(mock_room)
    end
    
    describe "with mime type of xml" do

      it "should render the requested room as xml" do
        request.env["HTTP_ACCEPT"] = "application/xml"
        mock(Room).find("37"){mock_room}
        mock(mock_room).to_xml{"generated XML"}
        get :show, :id => "37"
        response.body.should == "generated XML"
      end

    end
    
  end

  describe "responding to GET new" do
  
    it "should expose a new room as @room" do
      #We need to call new before any mocking
      mock_room
      mock(Room).new{mock_room}
      get :new
      assigns[:room].should equal(mock_room)
    end

  end

  describe "responding to GET edit" do
  
    it "should expose the requested room as @room" do
      mock(Room).find("37"){mock_room}
      get :edit, :id => "37"
      assigns[:room].should equal(mock_room)
    end

  end

  describe "responding to POST create" do

    describe "with valid params" do
      
      it "should expose a newly created room as @room" do
        room = mock_room(:save => true)
        mock(Room).new({'these' => 'params', 'user_id' => 1}){room}
        post :create, :room => {:these => 'params'}
        assigns(:room).should equal(mock_room)
      end

      it "should redirect to the created room" do
        room = mock_room(:save => true)
        stub(Room).new{room}
        post :create, :room => {}
        response.should redirect_to(room_url(mock_room))
      end
      
    end
    
    describe "with invalid params" do

      it "should expose a newly created but unsaved room as @room" do
        room = mock_room(:save => false)
        stub(Room).new({'these' => 'params', 'user_id' => 1}){room}
        post :create, :room => {:these => 'params'}
        assigns(:room).should equal(mock_room)
      end

      it "should re-render the 'new' template" do
        room = mock_room(:save => false)
        stub(Room).new{room}
        post :create, :room => {}
        response.should render_template('new')
      end
      
    end
    
  end

  describe "responding to PUT update" do

    describe "with valid params" do

      it "should update the requested room" do
        mock(Room).find("37"){mock_room}
        mock(mock_room).update_attributes({'these' => 'params'})
        put :update, :id => "37", :room => {:these => 'params'}
      end

      it "should expose the requested room as @room" do
        stub(Room).find{mock_room(:update_attributes => true)}
        put :update, :id => "1"
        assigns(:room).should equal(mock_room)
      end

      it "should redirect to the room" do
        stub(Room).find{mock_room(:update_attributes => true)}
        put :update, :id => "1"
        response.should redirect_to(room_url(mock_room))
      end

    end
    
    describe "with invalid params" do

      it "should update the requested room" do
        mock(Room).find("37"){mock_room}
        mock(mock_room).update_attributes({'these' => 'params'})
        put :update, :id => "37", :room => {:these => 'params'}
      end

      it "should expose the room as @room" do
        stub(Room).find{mock_room(:update_attributes => false)}
        put :update, :id => "1"
        assigns(:room).should equal(mock_room)
      end

      it "should re-render the 'edit' template" do
        stub(Room).find{mock_room(:update_attributes => false)}
        put :update, :id => "1"
        response.should render_template('edit')
      end

    end

  end

  describe "responding to DELETE destroy" do

    it "should destroy the requested room" do
      mock(Room).find("37"){mock_room}
      mock(mock_room).destroy
      delete :destroy, :id => "37"
    end
  
    it "should redirect to the rooms list" do
      stub(Room).find(){mock_room(:destroy => true)}
      delete :destroy, :id => "1"
      response.should redirect_to(rooms_url)
    end

  end

end
