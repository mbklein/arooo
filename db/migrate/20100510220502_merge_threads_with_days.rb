class MergeThreadsWithDays < ActiveRecord::Migration
  def self.up
    add_column :days, :topic_id, :integer
    add_column :days, :last_page, :integer
    add_column :days, :last_post, :integer
    Day.find(:all).each { |day|
      details = ActiveRecord::Base.connection.execute("SELECT topic_id, last_page, last_post FROM day_threads WHERE day_id = #{day.id}").first
      day.update_attributes :topic_id => details['topic_id'], :last_page => details['last_page'], :last_post => details['last_post']
    }
    drop_table :day_threads
  end

  def self.down
    raise ActiveRecord::IrreversibleMigration
  end
end
