class Ladder < ActiveRecord::Base
  validates_length_of :name, :in => 3..50
  validates_length_of :game, :in => 3..50
end
