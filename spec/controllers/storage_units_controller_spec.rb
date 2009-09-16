require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe StorageUnitsController do
  include Authlogic::TestCase
  setup :activate_authlogic

  def mock_storage_unit(stubs={})
    @mock_storage_unit ||= mock_model(StorageUnit, stubs)
  end

  before do
    UserSession.create(@current_user = User.make)
  end
  
  describe "responding to GET index" do

    it "should expose all storage_units as @storage_units" do
      mock(StorageUnit).find(:all){[mock_storage_unit]}
      get :index
      assigns[:storage_units].should == [mock_storage_unit]
    end

    describe "with mime type of xml" do
  
      it "should render all storage_units as xml" do
        request.env["HTTP_ACCEPT"] = "application/xml"
        storage_units = []
        mock(StorageUnit).find(:all){storage_units}
        mock(storage_units).to_xml(){"generated XML"}
        get :index
        response.body.should == "generated XML"
      end
    
    end

  end

  describe "responding to GET show" do

    it "should expose the requested storage_unit as @storage_unit" do
      mock(StorageUnit).find("37"){mock_storage_unit}
      get :show, :id => "37"
      assigns[:storage_unit].should equal(mock_storage_unit)
    end
    
    describe "with mime type of xml" do

      it "should render the requested storage_unit as xml" do
        request.env["HTTP_ACCEPT"] = "application/xml"
        mock(StorageUnit).find("37"){mock_storage_unit}
        mock(mock_storage_unit).to_xml{"generated XML"}
        get :show, :id => "37"
        response.body.should == "generated XML"
      end

    end
    
  end

  describe "responding to GET new" do
  
    it "should expose a new storage_unit as @storage_unit" do
      #We need to call new before any mocking
      mock_storage_unit
      mock(StorageUnit).new{mock_storage_unit}
      get :new
      assigns[:storage_unit].should equal(mock_storage_unit)
    end

  end

  describe "responding to GET edit" do
  
    it "should expose the requested storage_unit as @storage_unit" do
      mock(StorageUnit).find("37"){mock_storage_unit}
      get :edit, :id => "37"
      assigns[:storage_unit].should equal(mock_storage_unit)
    end

  end

  describe "responding to POST create" do

    describe "with valid params" do
      
      it "should expose a newly created storage_unit as @storage_unit" do
        storage_unit = mock_storage_unit(:save => true)
        mock(StorageUnit).new({'these' => 'params', 'user_id' => 1}){storage_unit}
        post :create, :storage_unit => {:these => 'params'}
        assigns(:storage_unit).should equal(mock_storage_unit)
      end

      it "should redirect to the created storage_unit" do
        storage_unit = mock_storage_unit(:save => true)
        stub(StorageUnit).new{storage_unit}
        post :create, :storage_unit => {}
        response.should redirect_to(storage_unit_url(mock_storage_unit))
      end
      
    end
    
    describe "with invalid params" do

      it "should expose a newly created but unsaved storage_unit as @storage_unit" do
        storage_unit = mock_storage_unit(:save => false)
        stub(StorageUnit).new({'these' => 'params', 'user_id' => 1}){storage_unit}
        post :create, :storage_unit => {:these => 'params'}
        assigns(:storage_unit).should equal(mock_storage_unit)
      end

      it "should re-render the 'new' template" do
        storage_unit = mock_storage_unit(:save => false)
        stub(StorageUnit).new{storage_unit}
        post :create, :storage_unit => {}
        response.should render_template('new')
      end
      
    end
    
  end

  describe "responding to PUT update" do

    describe "with valid params" do

      it "should update the requested storage_unit" do
        mock(StorageUnit).find("37"){mock_storage_unit}
        mock(mock_storage_unit).update_attributes({'these' => 'params'})
        put :update, :id => "37", :storage_unit => {:these => 'params'}
      end

      it "should expose the requested storage_unit as @storage_unit" do
        stub(StorageUnit).find{mock_storage_unit(:update_attributes => true)}
        put :update, :id => "1"
        assigns(:storage_unit).should equal(mock_storage_unit)
      end

      it "should redirect to the storage_unit" do
        stub(StorageUnit).find{mock_storage_unit(:update_attributes => true)}
        put :update, :id => "1"
        response.should redirect_to(storage_unit_url(mock_storage_unit))
      end

    end
    
    describe "with invalid params" do

      it "should update the requested storage_unit" do
        mock(StorageUnit).find("37"){mock_storage_unit}
        mock(mock_storage_unit).update_attributes({'these' => 'params'})
        put :update, :id => "37", :storage_unit => {:these => 'params'}
      end

      it "should expose the storage_unit as @storage_unit" do
        stub(StorageUnit).find{mock_storage_unit(:update_attributes => false)}
        put :update, :id => "1"
        assigns(:storage_unit).should equal(mock_storage_unit)
      end

      it "should re-render the 'edit' template" do
        stub(StorageUnit).find{mock_storage_unit(:update_attributes => false)}
        put :update, :id => "1"
        response.should render_template('edit')
      end

    end

  end

  describe "responding to DELETE destroy" do

    it "should destroy the requested storage_unit" do
      mock(StorageUnit).find("37"){mock_storage_unit}
      mock(mock_storage_unit).destroy
      delete :destroy, :id => "37"
    end
  
    it "should redirect to the storage_units list" do
      stub(StorageUnit).find(){mock_storage_unit(:destroy => true)}
      delete :destroy, :id => "1"
      response.should redirect_to(storage_units_url)
    end

  end

end
