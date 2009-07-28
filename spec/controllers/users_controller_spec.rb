require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe UsersController do

  def mock_user(stubs={})
    @mock_user ||= mock_model(User, stubs)
  end
  
  describe "responding to GET index" do

    it "should expose all users as @users" do
      mock(User).find(:all){[mock_user]}
      get :index
      assigns[:users].should == [mock_user]
    end

    describe "with mime type of xml" do
  
      it "should render all users as xml" do
        request.env["HTTP_ACCEPT"] = "application/xml"
        users = []
        mock(User).find(:all){users}
        mock(users).to_xml(){"generated XML"}
        get :index
        response.body.should == "generated XML"
      end
    
    end

  end

  describe "responding to GET show" do

    it "should expose the requested user as @user" do
      mock(User).find("37"){mock_user}
      get :show, :id => "37"
      assigns[:user].should equal(mock_user)
    end
    
    describe "with mime type of xml" do

      it "should render the requested user as xml" do
        request.env["HTTP_ACCEPT"] = "application/xml"
        mock(User).find("37"){mock_user}
        mock(mock_user).to_xml{"generated XML"}
        get :show, :id => "37"
        response.body.should == "generated XML"
      end

    end
    
  end

  describe "responding to GET new" do
  
    it "should expose a new user as @user" do
      #We need to call new before any mocking
      mock_user
      mock(User).new{mock_user}
      get :new
      assigns[:user].should equal(mock_user)
    end

  end

  describe "responding to GET edit" do
  
    it "should expose the requested user as @user" do
      mock(User).find("37"){mock_user}
      get :edit, :id => "37"
      assigns[:user].should equal(mock_user)
    end

  end

  describe "responding to POST create" do

    describe "with valid params" do
      
      it "should expose a newly created user as @user" do
        user = mock_user(:save => true)
        mock(User).new({'these' => 'params'}){user}
        post :create, :user => {:these => 'params'}
        assigns(:user).should equal(mock_user)
      end

      it "should redirect to the created user" do
        user = mock_user(:save => true)
        stub(User).new{user}
        post :create, :user => {}
        response.should redirect_to(user_url(mock_user))
      end
      
    end
    
    describe "with invalid params" do

      it "should expose a newly created but unsaved user as @user" do
        user = mock_user(:save => false)
        stub(User).new({'these' => 'params'}){user}
        post :create, :user => {:these => 'params'}
        assigns(:user).should equal(mock_user)
      end

      it "should re-render the 'new' template" do
        user = mock_user(:save => false)
        stub(User).new{user}
        post :create, :user => {}
        response.should render_template('new')
      end
      
    end
    
  end

  describe "responding to PUT udpate" do

    describe "with valid params" do

      it "should update the requested user" do
        mock(User).find("37"){mock_user}
        mock(mock_user).update_attributes({'these' => 'params'})
        put :update, :id => "37", :user => {:these => 'params'}
      end

      it "should expose the requested user as @user" do
        stub(User).find{mock_user(:update_attributes => true)}
        put :update, :id => "1"
        assigns(:user).should equal(mock_user)
      end

      it "should redirect to the user" do
        stub(User).find{mock_user(:update_attributes => true)}
        put :update, :id => "1"
        response.should redirect_to(user_url(mock_user))
      end

    end
    
    describe "with invalid params" do

      it "should update the requested user" do
        mock(User).find("37"){mock_user}
        mock(mock_user).update_attributes({'these' => 'params'})
        put :update, :id => "37", :user => {:these => 'params'}
      end

      it "should expose the user as @user" do
        stub(User).find{mock_user(:update_attributes => false)}
        put :update, :id => "1"
        assigns(:user).should equal(mock_user)
      end

      it "should re-render the 'edit' template" do
        stub(User).find{mock_user(:update_attributes => false)}
        put :update, :id => "1"
        response.should render_template('edit')
      end

    end

  end

  describe "responding to DELETE destroy" do

    it "should destroy the requested user" do
      mock(User).find("37"){mock_user}
      mock(mock_user).destroy
      delete :destroy, :id => "37"
    end
  
    it "should redirect to the users list" do
      stub(User).find(){mock_user(:destroy => true)}
      delete :destroy, :id => "1"
      response.should redirect_to(users_url)
    end

  end

end
