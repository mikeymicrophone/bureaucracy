require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe BuildingsController do
  include Authlogic::TestCase
  setup :activate_authlogic

  def mock_building(stubs={})
    @mock_building ||= mock_model(Building, stubs)
  end

  before do
    UserSession.create User.make
  end
  
  describe "responding to GET index" do

    it "should expose all buildings as @buildings" do
      mock(Building).find(:all){[mock_building]}
      get :index
      assigns[:buildings].should == [mock_building]
    end

    describe "with mime type of xml" do
  
      it "should render all buildings as xml" do
        request.env["HTTP_ACCEPT"] = "application/xml"
        buildings = []
        mock(Building).find(:all){buildings}
        mock(buildings).to_xml(){"generated XML"}
        get :index
        response.body.should == "generated XML"
      end
    
    end

  end

  describe "responding to GET show" do

    it "should expose the requested building as @building" do
      mock(Building).find("37"){mock_building}
      get :show, :id => "37"
      assigns[:building].should equal(mock_building)
    end
    
    describe "with mime type of xml" do

      it "should render the requested building as xml" do
        request.env["HTTP_ACCEPT"] = "application/xml"
        mock(Building).find("37"){mock_building}
        mock(mock_building).to_xml{"generated XML"}
        get :show, :id => "37"
        response.body.should == "generated XML"
      end

    end
    
  end

  describe "responding to GET new" do
  
    it "should expose a new building as @building" do
      #We need to call new before any mocking
      mock_building
      mock(Building).new{mock_building}
      get :new
      assigns[:building].should equal(mock_building)
    end

  end

  describe "responding to GET edit" do
  
    it "should expose the requested building as @building" do
      mock(Building).find("37"){mock_building}
      get :edit, :id => "37"
      assigns[:building].should equal(mock_building)
    end

  end

  describe "responding to POST create" do

    describe "with valid params" do
      
      it "should expose a newly created building as @building" do
        building = mock_building(:save => true)
        mock(Building).new({'these' => 'params', 'user_id' => 1}){building}
        post :create, :building => {:these => 'params'}
        assigns(:building).should equal(mock_building)
      end

      it "should redirect to the created building" do
        building = mock_building(:save => true)
        stub(Building).new{building}
        post :create, :building => {}
        response.should redirect_to(building_url(mock_building))
      end
      
    end
    
    describe "with invalid params" do

      it "should expose a newly created but unsaved building as @building" do
        building = mock_building(:save => false)
        stub(Building).new({'these' => 'params', 'user_id' => 1}){building}
        post :create, :building => {:these => 'params'}
        assigns(:building).should equal(mock_building)
      end

      it "should re-render the 'new' template" do
        building = mock_building(:save => false)
        stub(Building).new{building}
        post :create, :building => {}
        response.should render_template('new')
      end
      
    end
    
  end

  describe "responding to PUT update" do

    describe "with valid params" do

      it "should update the requested building" do
        mock(Building).find("37"){mock_building}
        mock(mock_building).update_attributes({'these' => 'params'})
        put :update, :id => "37", :building => {:these => 'params'}
      end

      it "should expose the requested building as @building" do
        stub(Building).find{mock_building(:update_attributes => true)}
        put :update, :id => "1"
        assigns(:building).should equal(mock_building)
      end

      it "should redirect to the building" do
        stub(Building).find{mock_building(:update_attributes => true)}
        put :update, :id => "1"
        response.should redirect_to(building_url(mock_building))
      end

    end
    
    describe "with invalid params" do

      it "should update the requested building" do
        mock(Building).find("37"){mock_building}
        mock(mock_building).update_attributes({'these' => 'params'})
        put :update, :id => "37", :building => {:these => 'params'}
      end

      it "should expose the building as @building" do
        stub(Building).find{mock_building(:update_attributes => false)}
        put :update, :id => "1"
        assigns(:building).should equal(mock_building)
      end

      it "should re-render the 'edit' template" do
        stub(Building).find{mock_building(:update_attributes => false)}
        put :update, :id => "1"
        response.should render_template('edit')
      end

    end

  end

  describe "responding to DELETE destroy" do

    it "should destroy the requested building" do
      mock(Building).find("37"){mock_building}
      mock(mock_building).destroy
      delete :destroy, :id => "37"
    end
  
    it "should redirect to the buildings list" do
      stub(Building).find(){mock_building(:destroy => true)}
      delete :destroy, :id => "1"
      response.should redirect_to(buildings_url)
    end

  end

end
