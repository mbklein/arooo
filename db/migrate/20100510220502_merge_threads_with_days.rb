class MergeThreadsWithDays < ActiveRecord::Migration
  def self.up
    add_column :days, :topic_id, :integer
    add_column :days, :last_page, :integer
    add_column :days, :last_post, :integer
    Day.find(:all).each { |day|
      day.update_attributes :topic_id => day.thread.topic_id, :last_page => day.thread.last_page, :last_post => day.thread.last_post
    }
    drop_table :day_threads
  end

  def self.down
    raise ActiveRecord::IrreversibleMigration
  end
end
