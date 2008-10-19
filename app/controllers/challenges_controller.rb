class ChallengesController < ApplicationController
  resources_controller_for :challenges

  before_filter :login_required
  before_filter :load_challenge, :except => [:new, :create]

  def won
    @challenge.won!
  end

  def lost
    @challenge.lost!
  end

  response_for :won, :lost do |format|
    format.html do
      flash[:notice] = "Challenge updated"
      redirect_to :back
    end
  end

  response_for :create do |format|
    format.html do
      if @challenge.new_record?
        flash[:error] = "Couldn't create your challenge!"
      else
        flash[:notice] = "Successfully created your challenge!"
      end
      redirect_to enclosing_resource
    end
  end

  private

  def new_resource
    returning Challenge.new(params[:challenge]) do |challenge|
      challenge.challenger = current_player
      challenge.challengee = Player.find(params[:challengee_id])
      challenge.ladder = enclosing_resource
    end
  end

  def load_challenge
    @challenge = Challenge.find(params[:id])
  end
end
