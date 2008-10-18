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
end
