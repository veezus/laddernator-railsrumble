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
  
  describe "creating" do
    it "should add the rank to the bottom of the list for its ladder" do
      ladder = Ladder.generate!
      rank = Rank.generate!(:ladder => ladder)
      rank2 = Rank.generate!(:ladder => ladder)

      ladder.ranks.last.should == rank2
    end
  end
end
