class IgnoreBogusVotes < ActiveRecord::Migration
  def self.up
    add_column :votes, :ignore, :boolean, :default => false
  end

  def self.down
    remove_column :votes, :ignore
  end
end
