require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe LaddersController do
  describe "route generation" do
    it "should map #index" do
      route_for(:controller => "ladders", :action => "index").should == "/ladders"
    end
  
    it "should map #new" do
      route_for(:controller => "ladders", :action => "new").should == "/ladders/new"
    end
  
    it "should map #show" do
      route_for(:controller => "ladders", :action => "show", :id => 1).should == "/ladders/1"
    end
  
    it "should map #edit" do
      route_for(:controller => "ladders", :action => "edit", :id => 1).should == "/ladders/1/edit"
    end
  
    it "should map #update" do
      route_for(:controller => "ladders", :action => "update", :id => 1).should == "/ladders/1"
    end
  
    it "should map #destroy" do
      route_for(:controller => "ladders", :action => "destroy", :id => 1).should == "/ladders/1"
    end
  end

  describe "route recognition" do
    it "should generate params for #index" do
      params_from(:get, "/ladders").should == {:controller => "ladders", :action => "index"}
    end
  
    it "should generate params for #new" do
      params_from(:get, "/ladders/new").should == {:controller => "ladders", :action => "new"}
    end
  
    it "should generate params for #create" do
      params_from(:post, "/ladders").should == {:controller => "ladders", :action => "create"}
    end
  
    it "should generate params for #show" do
      params_from(:get, "/ladders/1").should == {:controller => "ladders", :action => "show", :id => "1"}
    end
  
    it "should generate params for #edit" do
      params_from(:get, "/ladders/1/edit").should == {:controller => "ladders", :action => "edit", :id => "1"}
    end
  
    it "should generate params for #update" do
      params_from(:put, "/ladders/1").should == {:controller => "ladders", :action => "update", :id => "1"}
    end
  
    it "should generate params for #destroy" do
      params_from(:delete, "/ladders/1").should == {:controller => "ladders", :action => "destroy", :id => "1"}
    end
  end
end
