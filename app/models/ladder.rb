class Ladder < ActiveRecord::Base
  has_many   :ranks, :order => 'position'
  has_many   :players, :through => :ranks, :order => 'ranks.position'
  has_many   :challenges
  belongs_to :owner, :class_name => 'Player'
  
  validates_presence_of :name, :game
  validates_length_of :name, :in => 3..50
  validates_length_of :game, :in => 3..50

  REJECTIONS_ALLOWED = 3
  
  def owned_by?(player)
    owner == player
  end

  def rejections_left_for(player)
    if most_recent_accepted_challenge = challenges.for_player(player).accepted.select{|c| c.challenger?(player)}.last
      REJECTIONS_ALLOWED - challenges.rejections_since(most_recent_accepted_challenge).size
    else
      REJECTIONS_ALLOWED - challenges.for_player(player).rejected.size
    end
  end

  def last_rejection_for?(player)
    rejections_left_for(player) == 1
  end

end
