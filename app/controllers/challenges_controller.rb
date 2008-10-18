class ChallengesController < ApplicationController
  before_filter :login_required
  resources_controller_for :challenges

  response_for :create do |format|
    format.html do
      redirect_to :back
    end
  end

  private

  def new_resource
    returning Challenge.new(params[:challenge]) do |challenge|
      challenge.challenger = current_player
    end
  end
end
