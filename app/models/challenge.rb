class Challenge < ActiveRecord::Base
  belongs_to :ladder
  belongs_to :challenger, :class_name => 'Player', :foreign_key => 'challenger_id'
  belongs_to :challengee, :class_name => 'Player', :foreign_key => 'challengee_id'
  after_create :send_notifications
  
  validates_presence_of   :challenger, :challengee, :ladder
  validates_uniqueness_of :challenger_id, :scope => :ladder_id, :if => Proc.new { |challenge| challenge.challenger && Challenge.for_player(challenge.challenger).pending.any? }
  validates_uniqueness_of :challengee_id, :scope => :ladder_id, :if => Proc.new { |challenge| challenge.challengee && Challenge.for_player(challenge.challengee).pending.any? }
  validate :membership_in_ladder, :position_of_challenger

  named_scope :pending, :conditions => 'completed_at is null'
  named_scope :for_player, lambda { |player| {:conditions => ['challenger_id = ? or challengee_id = ?', player.id, player.id] } }
  named_scope :today, lambda { |date| {:conditions => ['created_at >= ? AND created_at <= ?', Date.today.to_time, 1.second.ago(Date.tomorrow)]} }
  named_scope :on_ladder, lambda { |ladder| {:conditions => ['ladder_id = ?', ladder.id]} }
  
  def completed?
    !!completed_at
  end

  def challenger?(player)
    challenger == player
  end

  def challengee?(player)
    challengee == player
  end

  def won!
    update_attribute(:won, true)
    update_attribute(:completed_at, Time.now)
    challenger.rank_for(ladder).move_higher
  end

  def lost!
    update_attribute(:won, false)
    update_attribute(:completed_at, Time.now)
  end

  private

  #TODO
  def send_notifications
    #challenger.send_notifications
    #challengee.send_notifications
  end

  private

  def membership_in_ladder
    return false unless challenger && challengee
    unless challenger.rank_for(ladder) && challengee.rank_for(ladder)
      errors.add_to_base('Challenger and challengee must belong to the ladder')
      return false
    end
    return true
  end

  def position_of_challenger
    return false unless ladder && membership_in_ladder
    unless challengee.rank_for(ladder).position == challenger.rank_for(ladder).position - 1
      errors.add(:challenger, "must be ranked directly below challengee")
      return false
    end
    return true
  end
end
