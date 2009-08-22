require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe PlacementsController do
  describe "route generation" do
    it "maps #index" do
      route_for(:controller => "placements", :action => "index").should == "/placements"
    end

    it "maps #new" do
      route_for(:controller => "placements", :action => "new").should == "/placements/new"
    end

    it "maps #show" do
      route_for(:controller => "placements", :action => "show", :id => "1").should == "/placements/1"
    end

    it "maps #edit" do
      route_for(:controller => "placements", :action => "edit", :id => "1").should == "/placements/1/edit"
    end

    it "maps #create" do
      route_for(:controller => "placements", :action => "create").should == {:path => "/placements", :method => :post}
    end

    it "maps #update" do
      route_for(:controller => "placements", :action => "update", :id => "1").should == {:path =>"/placements/1", :method => :put}
    end

    it "maps #destroy" do
      route_for(:controller => "placements", :action => "destroy", :id => "1").should == {:path =>"/placements/1", :method => :delete}
    end
  end

  describe "route recognition" do
    it "generates params for #index" do
      params_from(:get, "/placements").should == {:controller => "placements", :action => "index"}
    end

    it "generates params for #new" do
      params_from(:get, "/placements/new").should == {:controller => "placements", :action => "new"}
    end

    it "generates params for #create" do
      params_from(:post, "/placements").should == {:controller => "placements", :action => "create"}
    end

    it "generates params for #show" do
      params_from(:get, "/placements/1").should == {:controller => "placements", :action => "show", :id => "1"}
    end

    it "generates params for #edit" do
      params_from(:get, "/placements/1/edit").should == {:controller => "placements", :action => "edit", :id => "1"}
    end

    it "generates params for #update" do
      params_from(:put, "/placements/1").should == {:controller => "placements", :action => "update", :id => "1"}
    end

    it "generates params for #destroy" do
      params_from(:delete, "/placements/1").should == {:controller => "placements", :action => "destroy", :id => "1"}
    end
  end
end
