class CreateGames < ActiveRecord::Migration
  def self.up
    create_table :games do |t|
      t.string :title
      t.integer :moderator_id
      t.integer :server_id
    end
  end

  def self.down
    drop_table :games
  end
end
