class Challenge < ActiveRecord::Base
  belongs_to :ladder
  belongs_to :challenger, :class_name => 'Player', :foreign_key => 'challenger_id'
  belongs_to :challengee, :class_name => 'Player', :foreign_key => 'challengee_id'
  after_create :send_notifications
  after_save :send_updates

  validates_presence_of   :challenger, :challengee, :ladder
  validate :membership_in_ladder, :position_of_challenger

  named_scope :pending, :conditions => 'completed_at is null'
  named_scope :for_player, lambda { |player| {:conditions => ['challenger_id = ? or challengee_id = ?', player.id, player.id] } }
  named_scope :with_challengee, lambda { |challengee| {:conditions => ['challengee_id = ?', challengee.id] } }
  named_scope :today, lambda { |date| {:conditions => ['created_at >= ? AND created_at <= ?', Date.today.to_time, 1.second.ago(Date.tomorrow)]} }
  named_scope :on_ladder, lambda { |ladder| {:conditions => ['ladder_id = ?', ladder.id]} }

  named_scope :accepted, :conditions => "status = 'accepted'"
  named_scope :rejected, :conditions => "status = 'rejected'"
  named_scope :rejections_since, lambda {|challenge| {:conditions => ["id > ? AND status = 'rejected'", challenge.id]} }

  def completed?
    !!completed_at
  end

  def challenger?(player)
    challenger == player
  end

  def challengee?(player)
    challengee == player
  end

  def won_by?(player)
    completed? && (challenger?(player) && won?) || (challengee?(player) && lost?)
  end

  def lost_by?(player)
    completed? && (challenger?(player) && lost?) || (challengee?(player) && won?)
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
  def lost?
    completed? && accepted? && !won
  end

  def accept!
    update_attribute(:status, "accepted")
  end
  def accepted?
    status == "accepted"
  end

  def reject!
    lost! if ladder.last_rejection_for?(challengee)
    update_attribute(:status, "rejected")
    update_attribute(:completed_at, Time.now)
  end

  def rejected?
    status == "rejected"
  end

  def unanswered?
    status == nil
  end

  def send_notifications
    Notification.deliver_challenged(challenger, challengee, self)
  end

  def send_updates
    if rejected?
      Notification.deliver_rejected_challenge(challenger, challengee)
    elsif accepted?
      Notification.deliver_accepted_challenge(challenger, challengee, self)
    end
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
