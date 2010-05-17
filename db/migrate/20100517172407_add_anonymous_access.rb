class AddAnonymousAccess < ActiveRecord::Migration
  def self.up
    add_column :games, :allow_anonymous_view, :boolean, :default => true
    add_column :games, :over, :boolean, :default => false
  end

  def self.down
    remove_column :games, :allow_anonymous_view
    remove_column :games, :over
  end
end
