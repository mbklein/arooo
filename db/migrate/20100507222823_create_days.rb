class CreateDays < ActiveRecord::Migration
  def self.up
    create_table :days do |t|
      t.integer :game_id
      t.integer :seq

      t.timestamps
    end
  end

  def self.down
    drop_table :days
  end
end
