class Player < ActiveRecord::Base
  has_many :ladders
  
  validates_length_of :first_name, :minimum => 3
  validates_length_of :last_name, :minimum => 3
  validates_length_of :email, :minimum => 5
end
