require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe ListItemsController do
  include Authlogic::TestCase
  setup :activate_authlogic

  def mock_list_item(stubs={})
    @mock_list_item ||= mock_model(ListItem, stubs)
  end

  before do
    UserSession.create User.make
  end
  
  describe "responding to GET index" do

    it "should expose all list_items as @list_items" do
      mock(ListItem).find(:all){[mock_list_item]}
      get :index
      assigns[:list_items].should == [mock_list_item]
    end

    describe "with mime type of xml" do
  
      it "should render all list_items as xml" do
        request.env["HTTP_ACCEPT"] = "application/xml"
        list_items = []
        mock(ListItem).find(:all){list_items}
        mock(list_items).to_xml(){"generated XML"}
        get :index
        response.body.should == "generated XML"
      end
    
    end

  end

  describe "responding to GET show" do

    it "should expose the requested list_item as @list_item" do
      mock(ListItem).find("37"){mock_list_item}
      get :show, :id => "37"
      assigns[:list_item].should equal(mock_list_item)
    end
    
    describe "with mime type of xml" do

      it "should render the requested list_item as xml" do
        request.env["HTTP_ACCEPT"] = "application/xml"
        mock(ListItem).find("37"){mock_list_item}
        mock(mock_list_item).to_xml{"generated XML"}
        get :show, :id => "37"
        response.body.should == "generated XML"
      end

    end
    
  end

  describe "responding to GET new" do
  
    it "should expose a new list_item as @list_item" do
      #We need to call new before any mocking
      mock_list_item
      mock(ListItem).new{mock_list_item}
      get :new
      assigns[:list_item].should equal(mock_list_item)
    end

  end

  describe "responding to GET edit" do
  
    it "should expose the requested list_item as @list_item" do
      mock(ListItem).find("37"){mock_list_item}
      get :edit, :id => "37"
      assigns[:list_item].should equal(mock_list_item)
    end

  end

  describe "responding to POST create" do

    describe "with valid params" do
      
      it "should expose a newly created list_item as @list_item" do
        list_item = mock_list_item(:save => true)
        mock(ListItem).new({'these' => 'params', 'user_id' => 1}){list_item}
        post :create, :list_item => {:these => 'params'}
        assigns(:list_item).should equal(mock_list_item)
      end

      it "should redirect to the created list_item" do
        list_item = mock_list_item(:save => true)
        stub(ListItem).new{list_item}
        post :create, :list_item => {}
        response.should redirect_to(list_item_url(mock_list_item))
      end
      
    end
    
    describe "with invalid params" do

      it "should expose a newly created but unsaved list_item as @list_item" do
        list_item = mock_list_item(:save => false)
        stub(ListItem).new({'these' => 'params', 'user_id' => 1}){list_item}
        post :create, :list_item => {:these => 'params'}
        assigns(:list_item).should equal(mock_list_item)
      end

      it "should re-render the 'new' template" do
        list_item = mock_list_item(:save => false)
        stub(ListItem).new{list_item}
        post :create, :list_item => {}
        response.should render_template('new')
      end
      
    end
    
  end

  describe "responding to PUT update" do

    describe "with valid params" do

      it "should update the requested list_item" do
        mock(ListItem).find("37"){mock_list_item}
        mock(mock_list_item).update_attributes({'these' => 'params'})
        put :update, :id => "37", :list_item => {:these => 'params'}
      end

      it "should expose the requested list_item as @list_item" do
        stub(ListItem).find{mock_list_item(:update_attributes => true)}
        put :update, :id => "1"
        assigns(:list_item).should equal(mock_list_item)
      end

      it "should redirect to the list_item" do
        stub(ListItem).find{mock_list_item(:update_attributes => true)}
        put :update, :id => "1"
        response.should redirect_to(list_item_url(mock_list_item))
      end

    end
    
    describe "with invalid params" do

      it "should update the requested list_item" do
        mock(ListItem).find("37"){mock_list_item}
        mock(mock_list_item).update_attributes({'these' => 'params'})
        put :update, :id => "37", :list_item => {:these => 'params'}
      end

      it "should expose the list_item as @list_item" do
        stub(ListItem).find{mock_list_item(:update_attributes => false)}
        put :update, :id => "1"
        assigns(:list_item).should equal(mock_list_item)
      end

      it "should re-render the 'edit' template" do
        stub(ListItem).find{mock_list_item(:update_attributes => false)}
        put :update, :id => "1"
        response.should render_template('edit')
      end

    end

  end

  describe "responding to DELETE destroy" do

    it "should destroy the requested list_item" do
      mock(ListItem).find("37"){mock_list_item}
      mock(mock_list_item).destroy
      delete :destroy, :id => "37"
    end
  
    it "should redirect to the list_items list" do
      stub(ListItem).find(){mock_list_item(:destroy => true)}
      delete :destroy, :id => "1"
      response.should redirect_to(list_items_url)
    end

  end

end
