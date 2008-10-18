require File.dirname(__FILE__) + '/../spec_helper'

# Be sure to include AuthenticatedTestHelper in spec/spec_helper.rb instead
# Then, you can remove it from this and the units test.
include AuthenticatedTestHelper

describe PlayersController do
  fixtures :players

  it 'allows signup' do
    lambda do
      create_player
      response.should be_redirect
    end.should change(Player, :count).by(1)
  end

  

  

  it 'requires login on signup' do
    lambda do
      create_player(:login => nil)
      assigns[:player].errors.on(:login).should_not be_nil
      response.should be_success
    end.should_not change(Player, :count)
  end
  
  it 'requires password on signup' do
    lambda do
      create_player(:password => nil)
      assigns[:player].errors.on(:password).should_not be_nil
      response.should be_success
    end.should_not change(Player, :count)
  end
  
  it 'requires password confirmation on signup' do
    lambda do
      create_player(:password_confirmation => nil)
      assigns[:player].errors.on(:password_confirmation).should_not be_nil
      response.should be_success
    end.should_not change(Player, :count)
  end

  it 'requires email on signup' do
    lambda do
      create_player(:email => nil)
      assigns[:player].errors.on(:email).should_not be_nil
      response.should be_success
    end.should_not change(Player, :count)
  end
  
  
  
  def create_player(options = {})
    post :create, :player => { :login => 'quire', :email => 'quire@example.com',
      :password => 'quire', :password_confirmation => 'quire' }.merge(options)
  end
end