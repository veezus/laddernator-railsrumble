class RanksController < ApplicationController
  before_filter :login_required, :only => :create

  def create
    @ladder = Ladder.find(params[:ladder_id])
    @ladder.ranks.find_or_create_by_player_id(current_player.id)
    redirect_to ladder_path(params[:ladder_id])
  end

  def destroy
    @ladder = Ladder.find(params[:ladder_id])
    @rank = @ladder.ranks.find(params[:id])
    if @rank.destroyable_by?(current_player)
      @rank.destroy
      redirect_to @ladder
    else
      access_denied
    end
  end
end
