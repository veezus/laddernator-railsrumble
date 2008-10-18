class CreateChallenges < ActiveRecord::Migration
  def self.up
    create_table :challenges do |t|
      t.integer :challenger_id
      t.integer :challengee_id
      t.boolean :won
      t.datetime :completed_at
      t.datetime :expires_at

      t.timestamps
    end
  end

  def self.down
    drop_table :challenges
  end
end
