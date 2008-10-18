class Challenge < ActiveRecord::Base
  belongs_to :challenger, :class_name => 'Player', :foreign_key => 'player_id'
  belongs_to :challengee, :class_name => 'Player', :foreign_key => 'player_id'
  
  validates_presence_of :challenger, :challengee
  
  def completed?
    !!completed_at
  end
end
