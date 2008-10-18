class Rank < ActiveRecord::Base
  belongs_to :player
  belongs_to :ladder
  
  validates_presence_of :player, :ladder
  
  acts_as_list :scope => :ladder_id

  def can_challenge?(rank)
    rank.ladder == ladder && rank.position.succ == position
  end
end
