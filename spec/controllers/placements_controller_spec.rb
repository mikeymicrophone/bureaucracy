require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe PlacementsController do

  def mock_placement(stubs={})
    @mock_placement ||= mock_model(Placement, stubs)
  end
  
  describe "responding to GET index" do

    it "should expose all placements as @placements" do
      mock(Placement).find(:all){[mock_placement]}
      get :index
      assigns[:placements].should == [mock_placement]
    end

    describe "with mime type of xml" do
  
      it "should render all placements as xml" do
        request.env["HTTP_ACCEPT"] = "application/xml"
        placements = []
        mock(Placement).find(:all){placements}
        mock(placements).to_xml(){"generated XML"}
        get :index
        response.body.should == "generated XML"
      end
    
    end

  end

  describe "responding to GET show" do

    it "should expose the requested placement as @placement" do
      mock(Placement).find("37"){mock_placement}
      get :show, :id => "37"
      assigns[:placement].should equal(mock_placement)
    end
    
    describe "with mime type of xml" do

      it "should render the requested placement as xml" do
        request.env["HTTP_ACCEPT"] = "application/xml"
        mock(Placement).find("37"){mock_placement}
        mock(mock_placement).to_xml{"generated XML"}
        get :show, :id => "37"
        response.body.should == "generated XML"
      end

    end
    
  end

  describe "responding to GET new" do
  
    it "should expose a new placement as @placement" do
      #We need to call new before any mocking
      mock_placement
      mock(Placement).new{mock_placement}
      get :new
      assigns[:placement].should equal(mock_placement)
    end

  end

  describe "responding to GET edit" do
  
    it "should expose the requested placement as @placement" do
      mock(Placement).find("37"){mock_placement}
      get :edit, :id => "37"
      assigns[:placement].should equal(mock_placement)
    end

  end

  describe "responding to POST create" do

    describe "with valid params" do
      
      it "should expose a newly created placement as @placement" do
        placement = mock_placement(:save => true)
        mock(Placement).new({'these' => 'params'}){placement}
        post :create, :placement => {:these => 'params'}
        assigns(:placement).should equal(mock_placement)
      end

      it "should redirect to the created placement" do
        placement = mock_placement(:save => true)
        stub(Placement).new{placement}
        post :create, :placement => {}
        response.should redirect_to(placement_url(mock_placement))
      end
      
    end
    
    describe "with invalid params" do

      it "should expose a newly created but unsaved placement as @placement" do
        placement = mock_placement(:save => false)
        stub(Placement).new({'these' => 'params'}){placement}
        post :create, :placement => {:these => 'params'}
        assigns(:placement).should equal(mock_placement)
      end

      it "should re-render the 'new' template" do
        placement = mock_placement(:save => false)
        stub(Placement).new{placement}
        post :create, :placement => {}
        response.should render_template('new')
      end
      
    end
    
  end

  describe "responding to PUT udpate" do

    describe "with valid params" do

      it "should update the requested placement" do
        mock(Placement).find("37"){mock_placement}
        mock(mock_placement).update_attributes({'these' => 'params'})
        put :update, :id => "37", :placement => {:these => 'params'}
      end

      it "should expose the requested placement as @placement" do
        stub(Placement).find{mock_placement(:update_attributes => true)}
        put :update, :id => "1"
        assigns(:placement).should equal(mock_placement)
      end

      it "should redirect to the placement" do
        stub(Placement).find{mock_placement(:update_attributes => true)}
        put :update, :id => "1"
        response.should redirect_to(placement_url(mock_placement))
      end

    end
    
    describe "with invalid params" do

      it "should update the requested placement" do
        mock(Placement).find("37"){mock_placement}
        mock(mock_placement).update_attributes({'these' => 'params'})
        put :update, :id => "37", :placement => {:these => 'params'}
      end

      it "should expose the placement as @placement" do
        stub(Placement).find{mock_placement(:update_attributes => false)}
        put :update, :id => "1"
        assigns(:placement).should equal(mock_placement)
      end

      it "should re-render the 'edit' template" do
        stub(Placement).find{mock_placement(:update_attributes => false)}
        put :update, :id => "1"
        response.should render_template('edit')
      end

    end

  end

  describe "responding to DELETE destroy" do

    it "should destroy the requested placement" do
      mock(Placement).find("37"){mock_placement}
      mock(mock_placement).destroy
      delete :destroy, :id => "37"
    end
  
    it "should redirect to the placements list" do
      stub(Placement).find(){mock_placement(:destroy => true)}
      delete :destroy, :id => "1"
      response.should redirect_to(placements_url)
    end

  end

end
