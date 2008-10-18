class Rank < ActiveRecord::Base
  belongs_to :player
  belongs_to :ladder
  
  validates_presence_of :player, :ladder, :position
  
  acts_as_list

  def can_challenge?(rank)
    rank.ladder == ladder && rank.position.succ == position
  end
end
