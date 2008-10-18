require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe LaddersController do

  def mock_ladder(stubs={})
    @mock_ladder ||= mock_model(Ladder, stubs)
  end
  
  describe "responding to GET index" do

    it "should expose all ladders as @ladders" do
      Ladder.should_receive(:find).with(:all).and_return([mock_ladder])
      get :index
      assigns[:ladders].should == [mock_ladder]
    end

    describe "with mime type of xml" do
  
      it "should render all ladders as xml" do
        request.env["HTTP_ACCEPT"] = "application/xml"
        Ladder.should_receive(:find).with(:all).and_return(ladders = mock("Array of Ladders"))
        ladders.should_receive(:to_xml).and_return("generated XML")
        get :index
        response.body.should == "generated XML"
      end
    
    end

  end

  describe "responding to GET show" do

    it "should expose the requested ladder as @ladder" do
      Ladder.should_receive(:find).with("37").and_return(mock_ladder)
      get :show, :id => "37"
      assigns[:ladder].should equal(mock_ladder)
    end
    
    describe "with mime type of xml" do

      it "should render the requested ladder as xml" do
        request.env["HTTP_ACCEPT"] = "application/xml"
        Ladder.should_receive(:find).with("37").and_return(mock_ladder)
        mock_ladder.should_receive(:to_xml).and_return("generated XML")
        get :show, :id => "37"
        response.body.should == "generated XML"
      end

    end
    
  end

  describe "responding to GET new" do
  
    it "should expose a new ladder as @ladder" do
      Ladder.should_receive(:new).and_return(mock_ladder)
      get :new
      assigns[:ladder].should equal(mock_ladder)
    end

  end

  describe "responding to GET edit" do
  
    it "should expose the requested ladder as @ladder" do
      Ladder.should_receive(:find).with("37").and_return(mock_ladder)
      get :edit, :id => "37"
      assigns[:ladder].should equal(mock_ladder)
    end

  end

  describe "responding to POST create" do

    describe "with valid params" do
      
      it "should expose a newly created ladder as @ladder" do
        Ladder.should_receive(:new).with({'these' => 'params'}).and_return(mock_ladder(:save => true))
        post :create, :ladder => {:these => 'params'}
        assigns(:ladder).should equal(mock_ladder)
      end

      it "should redirect to the created ladder" do
        Ladder.stub!(:new).and_return(mock_ladder(:save => true))
        post :create, :ladder => {}
        response.should redirect_to(ladder_url(mock_ladder))
      end
      
    end
    
    describe "with invalid params" do

      it "should expose a newly created but unsaved ladder as @ladder" do
        Ladder.stub!(:new).with({'these' => 'params'}).and_return(mock_ladder(:save => false))
        post :create, :ladder => {:these => 'params'}
        assigns(:ladder).should equal(mock_ladder)
      end

      it "should re-render the 'new' template" do
        Ladder.stub!(:new).and_return(mock_ladder(:save => false))
        post :create, :ladder => {}
        response.should render_template('new')
      end
      
    end
    
  end

  describe "responding to PUT udpate" do

    describe "with valid params" do

      it "should update the requested ladder" do
        Ladder.should_receive(:find).with("37").and_return(mock_ladder)
        mock_ladder.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :ladder => {:these => 'params'}
      end

      it "should expose the requested ladder as @ladder" do
        Ladder.stub!(:find).and_return(mock_ladder(:update_attributes => true))
        put :update, :id => "1"
        assigns(:ladder).should equal(mock_ladder)
      end

      it "should redirect to the ladder" do
        Ladder.stub!(:find).and_return(mock_ladder(:update_attributes => true))
        put :update, :id => "1"
        response.should redirect_to(ladder_url(mock_ladder))
      end

    end
    
    describe "with invalid params" do

      it "should update the requested ladder" do
        Ladder.should_receive(:find).with("37").and_return(mock_ladder)
        mock_ladder.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :ladder => {:these => 'params'}
      end

      it "should expose the ladder as @ladder" do
        Ladder.stub!(:find).and_return(mock_ladder(:update_attributes => false))
        put :update, :id => "1"
        assigns(:ladder).should equal(mock_ladder)
      end

      it "should re-render the 'edit' template" do
        Ladder.stub!(:find).and_return(mock_ladder(:update_attributes => false))
        put :update, :id => "1"
        response.should render_template('edit')
      end

    end

  end

  describe "responding to DELETE destroy" do

    it "should destroy the requested ladder" do
      Ladder.should_receive(:find).with("37").and_return(mock_ladder)
      mock_ladder.should_receive(:destroy)
      delete :destroy, :id => "37"
    end
  
    it "should redirect to the ladders list" do
      Ladder.stub!(:find).and_return(mock_ladder(:destroy => true))
      delete :destroy, :id => "1"
      response.should redirect_to(ladders_url)
    end

  end

end
