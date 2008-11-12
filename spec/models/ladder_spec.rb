require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Ladder do
  before do
    @ladder = Ladder.spawn
  end
  it "should require a name with length of at least 3" do
    @ladder.name = "aa"
    @ladder.valid?
    @ladder.errors.should be_invalid(:name)
  end
  
  it "should require a game with length of at least 3" do
    @ladder.game = "bb"
    @ladder.valid?
    @ladder.errors.should be_invalid(:game)
  end
  describe "#rejections_left_for" do
    before do
      @ladder = Ladder.generate!
      @veez = Player.generate!
      @durran = Player.generate!
      @reinh = Player.generate!
      [@veez, @durran, @reinh].each { |player| @ladder.ranks.create!(:player => player) }
    end
    it "should return 3 with no existing challenges" do
      @ladder.rejections_left_for(@veez).should == 3
    end
    it "should return 3 with existing challenges from other players" do
      2.times { Challenge.create!(:challengee => @durran, :challenger => @reinh, :ladder => @ladder, :status => 'rejected') }
      @ladder.rejections_left_for(@veez).should == 3
    end
    it "should return the correct number of remaining rejections" do
      2.times { Challenge.create!(:challengee => @durran, :challenger => @reinh, :ladder => @ladder, :status => 'rejected') }
      2.times { Challenge.create!(:challenger => @durran, :challengee => @veez, :ladder => @ladder, :status => 'rejected') }
      @ladder.rejections_left_for(@durran).should == 1
    end
  end
end
