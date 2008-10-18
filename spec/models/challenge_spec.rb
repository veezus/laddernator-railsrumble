require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Challenge do
  before do
    @challenge = Challenge.spawn
  end
  describe "validations" do
    it "should require a challenger" do
      @challenge.challenger = nil
      @challenge.valid?
      @challenge.errors.should be_invalid(:challenger)
    end

    it "should require a challengee" do
      @challenge.challengee = nil
      @challenge.valid?
      @challenge.errors.should be_invalid(:challengee)
    end

    it "should require a ladder" do
      @challenge.ladder = nil
      @challenge.valid?
      @challenge.errors.should be_invalid(:ladder)
    end

    it "should be valid if the challenger is one rank below the challengee" do
      ladder = Ladder.generate!
      challenger = Player.generate!
      challengee = Player.generate!
      challengee.ladders << ladder
      challenger.ladders << ladder

      Challenge.create!(:ladder => ladder, :challenger => challenger, :challengee => challengee).should be_valid
    end

    it "should not be valid if the challenger is above the challengee" do
      ladder = Ladder.generate!
      challenger = Player.generate!
      challengee = Player.generate!
      challenger.ladders << ladder
      challengee.ladders << ladder

      Challenge.create(:ladder => ladder, :challenger => challenger, :challengee => challengee).should_not be_valid
    end

    it "should not be valid if the challenger is more than one below the challengee" do
      ladder = Ladder.generate!
      challenger = Player.generate!
      challengee = Player.generate!
      challengee.ladders << ladder
      Player.generate!.ladders << ladder
      challenger.ladders << ladder

      Challenge.create(:ladder => ladder, :challenger => challenger, :challengee => challengee).should_not be_valid
    end
  end
  
  describe "#complete?" do
    it "should return false if completed_at is nil" do
      @challenge.completed_at = nil
      @challenge.should_not be_completed
    end
    it "should return true if completed_at is not null" do
      @challenge.completed_at = Time.now
      @challenge.should be_completed
    end
  end
end
