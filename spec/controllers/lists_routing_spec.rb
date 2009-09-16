require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe ListsController do
  describe "route generation" do
    it "maps #index" do
      route_for(:controller => "lists", :action => "index").should == "/lists"
    end

    it "maps #new" do
      route_for(:controller => "lists", :action => "new").should == "/lists/new"
    end

    it "maps #show" do
      route_for(:controller => "lists", :action => "show", :id => "1").should == "/lists/1"
    end

    it "maps #edit" do
      route_for(:controller => "lists", :action => "edit", :id => "1").should == "/lists/1/edit"
    end

    it "maps #create" do
      route_for(:controller => "lists", :action => "create").should == {:path => "/lists", :method => :post}
    end

    it "maps #update" do
      route_for(:controller => "lists", :action => "update", :id => "1").should == {:path =>"/lists/1", :method => :put}
    end

    it "maps #destroy" do
      route_for(:controller => "lists", :action => "destroy", :id => "1").should == {:path =>"/lists/1", :method => :delete}
    end
  end

  describe "route recognition" do
    it "generates params for #index" do
      params_from(:get, "/lists").should == {:controller => "lists", :action => "index"}
    end

    it "generates params for #new" do
      params_from(:get, "/lists/new").should == {:controller => "lists", :action => "new"}
    end

    it "generates params for #create" do
      params_from(:post, "/lists").should == {:controller => "lists", :action => "create"}
    end

    it "generates params for #show" do
      params_from(:get, "/lists/1").should == {:controller => "lists", :action => "show", :id => "1"}
    end

    it "generates params for #edit" do
      params_from(:get, "/lists/1/edit").should == {:controller => "lists", :action => "edit", :id => "1"}
    end

    it "generates params for #update" do
      params_from(:put, "/lists/1").should == {:controller => "lists", :action => "update", :id => "1"}
    end

    it "generates params for #destroy" do
      params_from(:delete, "/lists/1").should == {:controller => "lists", :action => "destroy", :id => "1"}
    end
  end
end
