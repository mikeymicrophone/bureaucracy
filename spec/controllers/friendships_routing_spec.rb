require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe FriendshipsController do
  describe "route generation" do
    it "maps #index" do
      route_for(:controller => "friendships", :action => "index").should == "/friendships"
    end

    it "maps #new" do
      route_for(:controller => "friendships", :action => "new").should == "/friendships/new"
    end

    it "maps #show" do
      route_for(:controller => "friendships", :action => "show", :id => "1").should == "/friendships/1"
    end

    it "maps #edit" do
      route_for(:controller => "friendships", :action => "edit", :id => "1").should == "/friendships/1/edit"
    end

    it "maps #create" do
      route_for(:controller => "friendships", :action => "create").should == {:path => "/friendships", :method => :post}
    end

    it "maps #update" do
      route_for(:controller => "friendships", :action => "update", :id => "1").should == {:path =>"/friendships/1", :method => :put}
    end

    it "maps #destroy" do
      route_for(:controller => "friendships", :action => "destroy", :id => "1").should == {:path =>"/friendships/1", :method => :delete}
    end
  end

  describe "route recognition" do
    it "generates params for #index" do
      params_from(:get, "/friendships").should == {:controller => "friendships", :action => "index"}
    end

    it "generates params for #new" do
      params_from(:get, "/friendships/new").should == {:controller => "friendships", :action => "new"}
    end

    it "generates params for #create" do
      params_from(:post, "/friendships").should == {:controller => "friendships", :action => "create"}
    end

    it "generates params for #show" do
      params_from(:get, "/friendships/1").should == {:controller => "friendships", :action => "show", :id => "1"}
    end

    it "generates params for #edit" do
      params_from(:get, "/friendships/1/edit").should == {:controller => "friendships", :action => "edit", :id => "1"}
    end

    it "generates params for #update" do
      params_from(:put, "/friendships/1").should == {:controller => "friendships", :action => "update", :id => "1"}
    end

    it "generates params for #destroy" do
      params_from(:delete, "/friendships/1").should == {:controller => "friendships", :action => "destroy", :id => "1"}
    end
  end
end
