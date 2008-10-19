class AddStatusToChallenge < ActiveRecord::Migration
  def self.up
    add_column :challenges, :status, :string
  end

  def self.down
    remove_column :challenges, :status
  end
end
