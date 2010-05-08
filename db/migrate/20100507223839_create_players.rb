class CreatePlayers < ActiveRecord::Migration
  def self.up
    create_table :players do |t|
      t.integer :person_id
      t.integer :game_id
      t.integer :seq
      t.string :role
      t.string :alignment
    end
  end

  def self.down
    drop_table :players
  end
end
