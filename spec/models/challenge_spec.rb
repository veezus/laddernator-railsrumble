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

  describe "named scopes" do
    before do
      @unanswered = Challenge.spawn(:status => nil)
      @accepted   = Challenge.spawn(:status => 'accepted')
      @rejected   = Challenge.spawn(:status => 'rejected')
      @completed  = Challenge.spawn(:completed_at => Time.now, :won => true)
      [@unanswered, @accepted, @rejected, @completed].each do |challenge|
        challenge.ladder.players << challenge.challengee
        challenge.ladder.players << challenge.challenger
        challenge.save!
      end
    end
    describe "pending" do
      it "should return the correct challenges" do
        Challenge.pending.should == [@unanswered, @accepted, @rejected]
      end
    end
    describe "accepted" do
      it "should return the correct challenges" do
        Challenge.accepted.should == [@accepted]
      end
    end
    describe "rejected" do
      it "should return the correct challenges" do
        Challenge.rejected.should == [@rejected]
      end
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

  describe "notifications" do
    it "should send the challengee a notification" do
      challengee = Player.generate!
      challenger = mock_model(Player)
      challenge = Challenge.new(:challenger => challenger, :challengee => challengee)
      Notification.should_receive(:deliver_challenged).with(challenger, challengee, challenge)
      challenge.save_without_validation
    end
    it "should send the challenger a notification when it is rejected" do
      challengee = Player.generate!
      challenger = Player.generate!
      challenge = Challenge.new(:challenger => challenger, :challengee => challengee, :ladder => Ladder.generate!)
      challenge.save_without_validation
      Notification.should_receive(:deliver_rejected_challenge).with(challenger, challengee)
      challenge.update_attribute(:status, "rejected")
    end
    it "should send the challenger a notification when it is accepted" do
      challengee = Player.generate!
      challenger = Player.generate!
      challenge = Challenge.new(:challenger => challenger, :challengee => challengee, :ladder => Ladder.generate!)
      challenge.save_without_validation
      Notification.should_receive(:deliver_accepted_challenge).with(challenger, challengee, challenge)
      challenge.update_attribute(:status, "accepted")
    end
  end
end
