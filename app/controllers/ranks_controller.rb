class RanksController < ApplicationController
  before_filter :login_required, :only => :create

  def create
    @ladder = Ladder.find(params[:ladder_id])
    @ladder.ranks.find_or_create_by_player_id(current_player.id)
    redirect_to ladder_path(params[:ladder_id])
  end
end
