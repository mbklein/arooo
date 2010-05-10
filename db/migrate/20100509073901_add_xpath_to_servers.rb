class AddXpathToServers < ActiveRecord::Migration
  def self.up
    add_column :servers, :xpath_to_vote, :string
    add_column :servers, :xpath_vote_to_user, :string
    add_column :servers, :xpath_vote_to_post_id, :string
  end

  def self.down
    remove_column :servers, :xpath_to_vote
    remove_column :servers, :xpath_vote_to_user
    remove_column :servers, :xpath_vote_to_post_id
  end
end
