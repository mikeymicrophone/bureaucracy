require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe ListsController do
  include Authlogic::TestCase
  setup :activate_authlogic

  def mock_list(stubs={})
    @mock_list ||= mock_model(List, stubs)
  end

  before do
    UserSession.create User.make
  end
  
  describe "responding to GET index" do

    it "should expose all lists as @lists" do
      mock(List).find(:all){[mock_list]}
      get :index
      assigns[:lists].should == [mock_list]
    end

    describe "with mime type of xml" do
  
      it "should render all lists as xml" do
        request.env["HTTP_ACCEPT"] = "application/xml"
        lists = []
        mock(List).find(:all){lists}
        mock(lists).to_xml(){"generated XML"}
        get :index
        response.body.should == "generated XML"
      end
    
    end

  end

  describe "responding to GET show" do

    it "should expose the requested list as @list" do
      mock(List).find("37"){mock_list}
      get :show, :id => "37"
      assigns[:list].should equal(mock_list)
    end
    
    describe "with mime type of xml" do

      it "should render the requested list as xml" do
        request.env["HTTP_ACCEPT"] = "application/xml"
        mock(List).find("37"){mock_list}
        mock(mock_list).to_xml{"generated XML"}
        get :show, :id => "37"
        response.body.should == "generated XML"
      end

    end
    
  end

  describe "responding to GET new" do
  
    it "should expose a new list as @list" do
      #We need to call new before any mocking
      mock_list
      mock(List).new{mock_list}
      get :new
      assigns[:list].should equal(mock_list)
    end

  end

  describe "responding to GET edit" do
  
    it "should expose the requested list as @list" do
      mock(List).find("37"){mock_list}
      get :edit, :id => "37"
      assigns[:list].should equal(mock_list)
    end

  end

  describe "responding to POST create" do

    describe "with valid params" do
      
      it "should expose a newly created list as @list" do
        list = mock_list(:save => true)
        mock(List).new({'these' => 'params', 'user_id' => 1}){list}
        post :create, :list => {:these => 'params'}
        assigns(:list).should equal(mock_list)
      end

      it "should redirect to the created list" do
        list = mock_list(:save => true)
        stub(List).new{list}
        post :create, :list => {}
        response.should redirect_to(list_url(mock_list))
      end
      
    end
    
    describe "with invalid params" do

      it "should expose a newly created but unsaved list as @list" do
        list = mock_list(:save => false)
        stub(List).new({'these' => 'params', 'user_id' => 1}){list}
        post :create, :list => {:these => 'params'}
        assigns(:list).should equal(mock_list)
      end

      it "should re-render the 'new' template" do
        list = mock_list(:save => false)
        stub(List).new{list}
        post :create, :list => {}
        response.should render_template('new')
      end
      
    end
    
  end

  describe "responding to PUT update" do

    describe "with valid params" do

      it "should update the requested list" do
        mock(List).find("37"){mock_list}
        mock(mock_list).update_attributes({'these' => 'params'})
        put :update, :id => "37", :list => {:these => 'params'}
      end

      it "should expose the requested list as @list" do
        stub(List).find{mock_list(:update_attributes => true)}
        put :update, :id => "1"
        assigns(:list).should equal(mock_list)
      end

      it "should redirect to the list" do
        stub(List).find{mock_list(:update_attributes => true)}
        put :update, :id => "1"
        response.should redirect_to(list_url(mock_list))
      end

    end
    
    describe "with invalid params" do

      it "should update the requested list" do
        mock(List).find("37"){mock_list}
        mock(mock_list).update_attributes({'these' => 'params'})
        put :update, :id => "37", :list => {:these => 'params'}
      end

      it "should expose the list as @list" do
        stub(List).find{mock_list(:update_attributes => false)}
        put :update, :id => "1"
        assigns(:list).should equal(mock_list)
      end

      it "should re-render the 'edit' template" do
        stub(List).find{mock_list(:update_attributes => false)}
        put :update, :id => "1"
        response.should render_template('edit')
      end

    end

  end

  describe "responding to DELETE destroy" do

    it "should destroy the requested list" do
      mock(List).find("37"){mock_list}
      mock(mock_list).destroy
      delete :destroy, :id => "37"
    end
  
    it "should redirect to the lists list" do
      stub(List).find(){mock_list(:destroy => true)}
      delete :destroy, :id => "1"
      response.should redirect_to(lists_url)
    end

  end

end
