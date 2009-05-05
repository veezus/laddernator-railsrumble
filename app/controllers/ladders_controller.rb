class LaddersController < ApplicationController
  resources_controller_for :ladders
  
  before_filter :login_required,  :only => [:new, :create]
    
  def new_resource
    returning resource_service.new(params[:ladder]) do |ladder|
      ladder.owner = current_player
      ladder.players << current_player
    end
  end

  response_for :show do |format|
    format.html do
      @current_challenge = current_challenge
    end
  end

  def current_challenge
    return nil unless current_player
    current_player.pending_challenge_on(self.resource)
  end
  
end
