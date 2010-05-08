class CreateVotes < ActiveRecord::Migration
  def self.up
    create_table :votes do |t|
      t.integer :day_id
      t.integer :seq
      t.integer :voter_id
      t.integer :target_id
      t.string  :target_name
      t.datetime :cast
      t.string :source_post
    end
  end

  def self.down
    drop_table :votes
  end
end
