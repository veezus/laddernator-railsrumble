class AddLadderIdToChallenges < ActiveRecord::Migration
  def self.up
    add_column :challenges, :ladder_id, :integer
  end

  def self.down
    remove_column :challenges, :ladder_id
  end
end
