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
    it "should have a position" do
      @rank.position = nil
      @rank.valid?
      @rank.errors.should be_invalid(:position)
    end
  end
end
