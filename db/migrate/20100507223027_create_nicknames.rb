class CreateNicknames < ActiveRecord::Migration
  def self.up
    create_table :nicknames do |t|
      t.integer :person_id
      t.string :nickname
    end
    add_index(:nicknames, :nickname, :unique => true)
  end

  def self.down
    drop_table :nicknames
  end
end
