class CreateVotes < ActiveRecord::Migration
  def self.up
    create_table :votes do |t|
      t.integer :day_id
      t.integer :seq
      t.integer :voter_id
      t.integer :target_id
      t.string :source_post

      t.timestamps
    end
  end

  def self.down
    drop_table :votes
  end
end
