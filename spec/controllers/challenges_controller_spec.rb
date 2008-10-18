require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe ChallengesController do
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
