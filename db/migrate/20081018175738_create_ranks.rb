class CreateRanks < ActiveRecord::Migration
  def self.up
    create_table :ranks do |t|
      t.integer :player_id
      t.integer :ladder_id
      t.integer :position

      t.timestamps
    end
  end

  def self.down
    drop_table :ranks
  end
end
