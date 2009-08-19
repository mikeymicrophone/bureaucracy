require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe BelongingsController do
  describe "route generation" do
    it "maps #index" do
      route_for(:controller => "belongings", :action => "index").should == "/belongings"
    end

    it "maps #new" do
      route_for(:controller => "belongings", :action => "new").should == "/belongings/new"
    end

    it "maps #show" do
      route_for(:controller => "belongings", :action => "show", :id => "1").should == "/belongings/1"
    end

    it "maps #edit" do
      route_for(:controller => "belongings", :action => "edit", :id => "1").should == "/belongings/1/edit"
    end

    it "maps #create" do
      route_for(:controller => "belongings", :action => "create").should == {:path => "/belongings", :method => :post}
    end

    it "maps #update" do
      route_for(:controller => "belongings", :action => "update", :id => "1").should == {:path =>"/belongings/1", :method => :put}
    end

    it "maps #destroy" do
      route_for(:controller => "belongings", :action => "destroy", :id => "1").should == {:path =>"/belongings/1", :method => :delete}
    end
  end

  describe "route recognition" do
    it "generates params for #index" do
      params_from(:get, "/belongings").should == {:controller => "belongings", :action => "index"}
    end

    it "generates params for #new" do
      params_from(:get, "/belongings/new").should == {:controller => "belongings", :action => "new"}
    end

    it "generates params for #create" do
      params_from(:post, "/belongings").should == {:controller => "belongings", :action => "create"}
    end

    it "generates params for #show" do
      params_from(:get, "/belongings/1").should == {:controller => "belongings", :action => "show", :id => "1"}
    end

    it "generates params for #edit" do
      params_from(:get, "/belongings/1/edit").should == {:controller => "belongings", :action => "edit", :id => "1"}
    end

    it "generates params for #update" do
      params_from(:put, "/belongings/1").should == {:controller => "belongings", :action => "update", :id => "1"}
    end

    it "generates params for #destroy" do
      params_from(:delete, "/belongings/1").should == {:controller => "belongings", :action => "destroy", :id => "1"}
    end
  end
end
