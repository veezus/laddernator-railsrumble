class Ladder < ActiveRecord::Base
  has_many   :players, :through => :rank
  belongs_to :owner, :class_name => :player
  
  validates_length_of :name, :in => 3..50
  validates_length_of :game, :in => 3..50
end
