class AddPlayerFate < ActiveRecord::Migration
  def self.up
    add_column :players, :fate, :string
    add_column :players, :death_day_id, :integer
  end

  def self.down
    remove_column :players, :fate
    remove_column :players, :death_day_id
  end
end
