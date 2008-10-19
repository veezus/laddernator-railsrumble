class AddEmailToLadder < ActiveRecord::Migration
  def self.up
    add_column :ladders, :email, :string
  end

  def self.down
    remove_column :ladders, :email
  end
end
