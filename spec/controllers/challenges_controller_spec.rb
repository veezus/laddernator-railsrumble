require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe ChallengesController do
  describe "routes" do
    it "should generate a correct url" do
      route_for(:ladder_id => 1, :controller => 'challenges', :action => 'accept', :id => 17).should == '/ladders/1/challenges/17/accept'
    end
    it "should generate params correctly from the url" do
      params_from(:get, '/ladders/1/challenges/17/accept').should == {:ladder_id => '1', :controller => 'challenges', :action => 'accept', :id => "17"}
    end
  end

  describe "creating a new challenge" do
    it "should assign the current player as the challenger" do
      player = Player.generate!
      login_as player
      post :create, :ladder_id => Ladder.generate!,
                    :challengee_id => Player.generate!

      assigns(:challenge).challenger.should == player
    end
  end

end
