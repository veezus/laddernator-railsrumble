require File.dirname(__FILE__) + '/../spec_helper'

# Be sure to include AuthenticatedTestHelper in spec/spec_helper.rb instead.
# Then, you can remove it from this and the functional test.
include AuthenticatedTestHelper

describe Player do
  fixtures :players
  
  describe "associations" do
    before do
      @player = Player.spawn
    end
    it "should have ladders" do
      @player.should respond_to(:ladders)
    end
  end

  describe 'being created' do
    before do
      @player = nil
      @creating_player = lambda do
        @player = create_player
        violated "#{@player.errors.full_messages.to_sentence}" if @player.new_record?
      end
    end
    
    it 'increments User#count' do
      @creating_player.should change(Player, :count).by(1)
    end
  end

  it 'requires login' do
    lambda do
      u = create_player(:login => nil)
      u.errors.on(:login).should_not be_nil
    end.should_not change(Player, :count)
  end

  it 'requires password' do
    lambda do
      u = create_player(:password => nil)
      u.errors.on(:password).should_not be_nil
    end.should_not change(Player, :count)
  end

  it 'requires password confirmation' do
    lambda do
      u = create_player(:password_confirmation => nil)
      u.errors.on(:password_confirmation).should_not be_nil
    end.should_not change(Player, :count)
  end

  it 'requires email' do
    lambda do
      u = create_player(:email => nil)
      u.errors.on(:email).should_not be_nil
    end.should_not change(Player, :count)
  end

  it 'resets password' do
    players(:quentin).update_attributes(:password => 'new password', :password_confirmation => 'new password')
    Player.authenticate('quentin', 'new password').should == players(:quentin)
  end

  it 'does not rehash password' do
    players(:quentin).update_attributes(:login => 'quentin2')
    Player.authenticate('quentin2', 'test').should == players(:quentin)
  end

  it 'authenticates player' do
    Player.authenticate('quentin', 'test').should == players(:quentin)
  end

  it 'sets remember token' do
    players(:quentin).remember_me
    players(:quentin).remember_token.should_not be_nil
    players(:quentin).remember_token_expires_at.should_not be_nil
  end

  it 'unsets remember token' do
    players(:quentin).remember_me
    players(:quentin).remember_token.should_not be_nil
    players(:quentin).forget_me
    players(:quentin).remember_token.should be_nil
  end

  it 'remembers me for one week' do
    before = 1.week.from_now.utc
    players(:quentin).remember_me_for 1.week
    after = 1.week.from_now.utc
    players(:quentin).remember_token.should_not be_nil
    players(:quentin).remember_token_expires_at.should_not be_nil
    players(:quentin).remember_token_expires_at.between?(before, after).should be_true
  end

  it 'remembers me until one week' do
    time = 1.week.from_now.utc
    players(:quentin).remember_me_until time
    players(:quentin).remember_token.should_not be_nil
    players(:quentin).remember_token_expires_at.should_not be_nil
    players(:quentin).remember_token_expires_at.should == time
  end

  it 'remembers me default two weeks' do
    before = 2.weeks.from_now.utc
    players(:quentin).remember_me
    after = 2.weeks.from_now.utc
    players(:quentin).remember_token.should_not be_nil
    players(:quentin).remember_token_expires_at.should_not be_nil
    players(:quentin).remember_token_expires_at.between?(before, after).should be_true
  end

protected
  def create_player(options = {})
    record = Player.new({ :login => 'quire', :email => 'quire@example.com', :password => 'quire', :password_confirmation => 'quire' }.merge(options))
    record.save
    record
  end
end
