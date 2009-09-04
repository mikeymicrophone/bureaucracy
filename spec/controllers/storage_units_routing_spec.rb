require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe StorageUnitsController do
  describe "route generation" do
    it "maps #index" do
      route_for(:controller => "storage_units", :action => "index").should == "/storage_units"
    end

    it "maps #new" do
      route_for(:controller => "storage_units", :action => "new").should == "/storage_units/new"
    end

    it "maps #show" do
      route_for(:controller => "storage_units", :action => "show", :id => "1").should == "/storage_units/1"
    end

    it "maps #edit" do
      route_for(:controller => "storage_units", :action => "edit", :id => "1").should == "/storage_units/1/edit"
    end

    it "maps #create" do
      route_for(:controller => "storage_units", :action => "create").should == {:path => "/storage_units", :method => :post}
    end

    it "maps #update" do
      route_for(:controller => "storage_units", :action => "update", :id => "1").should == {:path =>"/storage_units/1", :method => :put}
    end

    it "maps #destroy" do
      route_for(:controller => "storage_units", :action => "destroy", :id => "1").should == {:path =>"/storage_units/1", :method => :delete}
    end
  end

  describe "route recognition" do
    it "generates params for #index" do
      params_from(:get, "/storage_units").should == {:controller => "storage_units", :action => "index"}
    end

    it "generates params for #new" do
      params_from(:get, "/storage_units/new").should == {:controller => "storage_units", :action => "new"}
    end

    it "generates params for #create" do
      params_from(:post, "/storage_units").should == {:controller => "storage_units", :action => "create"}
    end

    it "generates params for #show" do
      params_from(:get, "/storage_units/1").should == {:controller => "storage_units", :action => "show", :id => "1"}
    end

    it "generates params for #edit" do
      params_from(:get, "/storage_units/1/edit").should == {:controller => "storage_units", :action => "edit", :id => "1"}
    end

    it "generates params for #update" do
      params_from(:put, "/storage_units/1").should == {:controller => "storage_units", :action => "update", :id => "1"}
    end

    it "generates params for #destroy" do
      params_from(:delete, "/storage_units/1").should == {:controller => "storage_units", :action => "destroy", :id => "1"}
    end
  end
end
