class LaddersController < ApplicationController
  resources_controller_for :ladders
  
  before_filter :login_required, :only => [:new, :create]
  before_filter :get_ladders
  
  def new_resource
    returning resource_service.new(params[:ladder]) do |ladder|
      ladder.owner = current_player
      ladder.players << current_player
    end
  end
  
end
