class CreateThreads < ActiveRecord::Migration
  def self.up
    create_table :day_threads do |t|
      t.integer :day_id
      t.integer :topic_id
      t.integer :last_page
      t.integer :last_post
    end
  end

  def self.down
    drop_table :day_threads
  end
end
