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

  def accept
    @challenge.accept!
  end

  def reject
    @challenge.reject!
    @challenge.lost! unless @challenge.ladder.rejections_left_for(@challenge.challengee)
  end

  response_for :won, :lost, :accept do |format|
    format.html do
      flash[:notice] = "Duly noted!"
      redirect_to enclosing_resource
    end
  end

  response_for :reject do |format|
    format.html do
      if @challenge.lost?
        flash[:notice] = "You lost by default for rejecting too many challenges!"
      end
      redirect_to enclosing_resource
    end
  end

  response_for :create do |format|
    format.any do
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
