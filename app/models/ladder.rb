class Ladder < ActiveRecord::Base
  has_many   :ranks, :order => 'position'
  has_many   :players, :through => :ranks
  belongs_to :owner, :class_name => 'Player'
  
  validates_length_of :name, :in => 3..50
  validates_length_of :game, :in => 3..50
  
  def owned_by?(player)
    owner == player
  end

end
