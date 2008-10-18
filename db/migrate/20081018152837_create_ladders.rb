class CreateLadders < ActiveRecord::Migration
  def self.up
    create_table :ladders do |t|
      t.string :name
      t.string :game

      t.timestamps
    end
  end

  def self.down
    drop_table :ladders
  end
end
