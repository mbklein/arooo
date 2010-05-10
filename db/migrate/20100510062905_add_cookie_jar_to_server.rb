class AddCookieJarToServer < ActiveRecord::Migration
  def self.up
    add_column :servers, :cookies, :text
  end

  def self.down
    remove_column :servers, :cookies
  end
end
