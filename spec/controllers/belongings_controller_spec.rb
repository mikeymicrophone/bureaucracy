require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe BelongingsController do

  def mock_belonging(stubs={})
    @mock_belonging ||= mock_model(Belonging, stubs)
  end
  
  describe "responding to GET index" do

    it "should expose all belongings as @belongings" do
      mock(Belonging).find(:all){[mock_belonging]}
      get :index
      assigns[:belongings].should == [mock_belonging]
    end

    describe "with mime type of xml" do
  
      it "should render all belongings as xml" do
        request.env["HTTP_ACCEPT"] = "application/xml"
        belongings = []
        mock(Belonging).find(:all){belongings}
        mock(belongings).to_xml(){"generated XML"}
        get :index
        response.body.should == "generated XML"
      end
    
    end

  end

  describe "responding to GET show" do

    it "should expose the requested belonging as @belonging" do
      mock(Belonging).find("37"){mock_belonging}
      get :show, :id => "37"
      assigns[:belonging].should equal(mock_belonging)
    end
    
    describe "with mime type of xml" do

      it "should render the requested belonging as xml" do
        request.env["HTTP_ACCEPT"] = "application/xml"
        mock(Belonging).find("37"){mock_belonging}
        mock(mock_belonging).to_xml{"generated XML"}
        get :show, :id => "37"
        response.body.should == "generated XML"
      end

    end
    
  end

  describe "responding to GET new" do
  
    it "should expose a new belonging as @belonging" do
      #We need to call new before any mocking
      mock_belonging
      mock(Belonging).new{mock_belonging}
      get :new
      assigns[:belonging].should equal(mock_belonging)
    end

  end

  describe "responding to GET edit" do
  
    it "should expose the requested belonging as @belonging" do
      mock(Belonging).find("37"){mock_belonging}
      get :edit, :id => "37"
      assigns[:belonging].should equal(mock_belonging)
    end

  end

  describe "responding to POST create" do

    describe "with valid params" do
      
      it "should expose a newly created belonging as @belonging" do
        belonging = mock_belonging(:save => true)
        mock(Belonging).new({'these' => 'params'}){belonging}
        post :create, :belonging => {:these => 'params'}
        assigns(:belonging).should equal(mock_belonging)
      end

      it "should redirect to the created belonging" do
        belonging = mock_belonging(:save => true)
        stub(Belonging).new{belonging}
        post :create, :belonging => {}
        response.should redirect_to(belonging_url(mock_belonging))
      end
      
    end
    
    describe "with invalid params" do

      it "should expose a newly created but unsaved belonging as @belonging" do
        belonging = mock_belonging(:save => false)
        stub(Belonging).new({'these' => 'params'}){belonging}
        post :create, :belonging => {:these => 'params'}
        assigns(:belonging).should equal(mock_belonging)
      end

      it "should re-render the 'new' template" do
        belonging = mock_belonging(:save => false)
        stub(Belonging).new{belonging}
        post :create, :belonging => {}
        response.should render_template('new')
      end
      
    end
    
  end

  describe "responding to PUT udpate" do

    describe "with valid params" do

      it "should update the requested belonging" do
        mock(Belonging).find("37"){mock_belonging}
        mock(mock_belonging).update_attributes({'these' => 'params'})
        put :update, :id => "37", :belonging => {:these => 'params'}
      end

      it "should expose the requested belonging as @belonging" do
        stub(Belonging).find{mock_belonging(:update_attributes => true)}
        put :update, :id => "1"
        assigns(:belonging).should equal(mock_belonging)
      end

      it "should redirect to the belonging" do
        stub(Belonging).find{mock_belonging(:update_attributes => true)}
        put :update, :id => "1"
        response.should redirect_to(belonging_url(mock_belonging))
      end

    end
    
    describe "with invalid params" do

      it "should update the requested belonging" do
        mock(Belonging).find("37"){mock_belonging}
        mock(mock_belonging).update_attributes({'these' => 'params'})
        put :update, :id => "37", :belonging => {:these => 'params'}
      end

      it "should expose the belonging as @belonging" do
        stub(Belonging).find{mock_belonging(:update_attributes => false)}
        put :update, :id => "1"
        assigns(:belonging).should equal(mock_belonging)
      end

      it "should re-render the 'edit' template" do
        stub(Belonging).find{mock_belonging(:update_attributes => false)}
        put :update, :id => "1"
        response.should render_template('edit')
      end

    end

  end

  describe "responding to DELETE destroy" do

    it "should destroy the requested belonging" do
      mock(Belonging).find("37"){mock_belonging}
      mock(mock_belonging).destroy
      delete :destroy, :id => "37"
    end
  
    it "should redirect to the belongings list" do
      stub(Belonging).find(){mock_belonging(:destroy => true)}
      delete :destroy, :id => "1"
      response.should redirect_to(belongings_url)
    end

  end

end
