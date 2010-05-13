class CreateAccesses < ActiveRecord::Migration
  def self.up
    create_table :accesses do |t|
      t.integer :user_id, :null => false
      t.integer :game_id, :null => false
      t.string  :role
      t.timestamps
    end
  end

  def self.down
    drop_table :accesses
  end
end
