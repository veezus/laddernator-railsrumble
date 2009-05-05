require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe LaddersController do

  describe "#current_challenge" do
    before do
      @player = Player.generate!
      @ladder = Ladder.generate!
      controller.stub!(:current_player).and_return(@player)
    end
    it "should return nil if there is no user logged in" do
      controller.stub!(:current_player).and_return(nil)
      controller.current_challenge.should be_nil
    end
    it "should return nil if the logged in user has no challenge" do
      @player.stub!(:pending_challenge_on).and_return(nil)
      controller.current_challenge.should be_nil
    end
    it "should return the challenge" do
      challenge = stub('stub')
      @player.stub!(:pending_challenge_on).and_return(challenge)
      controller.current_challenge.should == challenge
    end
  end

end
