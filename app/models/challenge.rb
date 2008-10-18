class Challenge < ActiveRecord::Base
  belongs_to :challenger, :class_name => 'Rank', :foreign_key => 'challenger_id'
  belongs_to :challengee, :class_name => 'Rank', :foreign_key => 'challengee_id'
  
  after_create :send_notifications
  
  validates_presence_of :challenger, :challengee
  
  def completed?
    !!completed_at
  end
  
  private
  
  def send_notifications
    challenger.player.send_notifications
    challengee.player.send_notifications
  end
end
