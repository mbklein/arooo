class CreateNicknames < ActiveRecord::Migration
  def self.up
    create_table :nicknames do |t|
      t.integer :person_id
      t.string :nickname

      t.timestamps
    end
  end

  def self.down
    drop_table :nicknames
  end
end
