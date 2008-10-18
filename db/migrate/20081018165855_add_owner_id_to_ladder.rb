class AddOwnerIdToLadder < ActiveRecord::Migration
  def self.up
    add_column :ladders, :owner_id, :integer
  end

  def self.down
    remove_column :ladders, :owner_id
  end
end
