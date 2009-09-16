require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe StoragesController do
  include Authlogic::TestCase
  setup :activate_authlogic

  def mock_storage(stubs={})
    @mock_storage ||= mock_model(Storage, stubs)
  end
  
  before do
    UserSession.create(@current_user = User.make)
  end
  
  describe "responding to GET index" do

    it "should expose all storages as @storages" do
      mock(Storage).find(:all){[mock_storage]}
      get :index
      assigns[:storages].should == [mock_storage]
    end

    describe "with mime type of xml" do
  
      it "should render all storages as xml" do
        request.env["HTTP_ACCEPT"] = "application/xml"
        storages = []
        mock(Storage).find(:all){storages}
        mock(storages).to_xml(){"generated XML"}
        get :index
        response.body.should == "generated XML"
      end
    
    end

  end

  describe "responding to GET show" do

    it "should expose the requested storage as @storage" do
      mock(Storage).find("37"){mock_storage}
      get :show, :id => "37"
      assigns[:storage].should equal(mock_storage)
    end
    
    describe "with mime type of xml" do

      it "should render the requested storage as xml" do
        request.env["HTTP_ACCEPT"] = "application/xml"
        mock(Storage).find("37"){mock_storage}
        mock(mock_storage).to_xml{"generated XML"}
        get :show, :id => "37"
        response.body.should == "generated XML"
      end

    end
    
  end

  describe "responding to GET new" do
  
    it "should expose a new storage as @storage" do
      #We need to call new before any mocking
      mock_storage
      mock(Storage).new{mock_storage}
      get :new
      assigns[:storage].should equal(mock_storage)
    end

  end

  describe "responding to GET edit" do
  
    it "should expose the requested storage as @storage" do
      mock(Storage).find("37"){mock_storage}
      get :edit, :id => "37"
      assigns[:storage].should equal(mock_storage)
    end

  end

  describe "responding to POST create" do

    describe "with valid params" do
      
      it "should expose a newly created storage as @storage" do
        storage = mock_storage(:save => true)
        mock(Storage).new({'these' => 'params', 'user_id' => 1}){storage}
        post :create, :storage => {:these => 'params'}
        assigns(:storage).should equal(mock_storage)
      end

      it "should redirect to the created storage" do
        storage = mock_storage(:save => true)
        stub(Storage).new{storage}
        post :create, :storage => {}
        response.should redirect_to(storage_url(mock_storage))
      end
      
    end
    
    describe "with invalid params" do

      it "should expose a newly created but unsaved storage as @storage" do
        storage = mock_storage(:save => false)
        stub(Storage).new({'these' => 'params', 'user_id' => 1}){storage}
        post :create, :storage => {:these => 'params'}
        assigns(:storage).should equal(mock_storage)
      end

      it "should re-render the 'new' template" do
        storage = mock_storage(:save => false)
        stub(Storage).new{storage}
        post :create, :storage => {}
        response.should render_template('new')
      end
      
    end
    
  end

  describe "responding to PUT update" do

    describe "with valid params" do

      it "should update the requested storage" do
        mock(Storage).find("37"){mock_storage}
        mock(mock_storage).update_attributes({'these' => 'params'})
        put :update, :id => "37", :storage => {:these => 'params'}
      end

      it "should expose the requested storage as @storage" do
        stub(Storage).find{mock_storage(:update_attributes => true)}
        put :update, :id => "1"
        assigns(:storage).should equal(mock_storage)
      end

      it "should redirect to the storage" do
        stub(Storage).find{mock_storage(:update_attributes => true)}
        put :update, :id => "1"
        response.should redirect_to(storage_url(mock_storage))
      end

    end
    
    describe "with invalid params" do

      it "should update the requested storage" do
        mock(Storage).find("37"){mock_storage}
        mock(mock_storage).update_attributes({'these' => 'params'})
        put :update, :id => "37", :storage => {:these => 'params'}
      end

      it "should expose the storage as @storage" do
        stub(Storage).find{mock_storage(:update_attributes => false)}
        put :update, :id => "1"
        assigns(:storage).should equal(mock_storage)
      end

      it "should re-render the 'edit' template" do
        stub(Storage).find{mock_storage(:update_attributes => false)}
        put :update, :id => "1"
        response.should render_template('edit')
      end

    end

  end

  describe "responding to DELETE destroy" do

    it "should destroy the requested storage" do
      mock(Storage).find("37"){mock_storage}
      mock(mock_storage).destroy
      delete :destroy, :id => "37"
    end
  
    it "should redirect to the storages list" do
      stub(Storage).find(){mock_storage(:destroy => true)}
      delete :destroy, :id => "1"
      response.should redirect_to(storages_url)
    end

  end

end
