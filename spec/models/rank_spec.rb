require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Rank do
  before do
    @rank = Rank.spawn
  end

  describe "validation" do
    it "should have a player" do
      @rank.player = nil
      @rank.valid?
      @rank.errors.should be_invalid(:player)
    end
    it "should have a ladder" do
      @rank.ladder = nil
      @rank.valid?
      @rank.errors.should be_invalid(:ladder)
    end
  end
  
  describe "#can_challenge?" do
    before do
      @ladder = Ladder.generate!
      @challengee = Rank.spawn(:ladder => @ladder, :position => 1)
      @challenger = Rank.spawn(:ladder => @ladder, :position => 5)
    end
    it "should return false if the ranks are on different ladders" do
      @challengee.ladder = Ladder.generate!
      @challenger.can_challenge?(@challengee).should be_false
    end
    it "should return false if the players are the same" do
      @challenger = @challengee
      @challenger.can_challenge?(@challengee).should be_false
    end
    it "should return false if the challenger is above the challengee" do
      @challengee.can_challenge?(@challenger).should be_false
    end
    it "should return false if the challeger is more than one below the challengee" do
      @challenger.can_challenge?(@challengee).should be_false
    end
    it "should return true if the challenger is one below the challengee" do
      @challenger.position = 2
      @challenger.can_challenge?(@challengee).should be_true
    end
  end

  describe "creating" do
    it "should add the rank to the bottom of the list for its ladder" do
      ladder = Ladder.generate!
      rank = Rank.generate!(:ladder => ladder)
      rank2 = Rank.generate!(:ladder => ladder)

      ladder.ranks.last.should == rank2
    end
  end
end
