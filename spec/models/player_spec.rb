require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Player do
  before do
    @player = Player.spawn
  end
  
  describe "validations" do
    it "should require a first name" do
      @player.first_name = nil
      @player.valid?
      @player.errors.should be_invalid(:first_name)
    end
    it "should require a last name" do
      @player.last_name = nil
      @player.valid?
      @player.errors.should be_invalid(:last_name)
    end
    it "should require an email" do
      @player.email = nil
      @player.valid?
      @player.errors.should be_invalid(:email)
    end
  end
  
  describe "associations" do
    it "should have ladders" do
      @player.should respond_to(:ladders)
    end
  end
end
