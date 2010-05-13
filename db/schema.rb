# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20100513053354) do

  create_table "accesses", :force => true do |t|
    t.integer  "user_id",    :null => false
    t.integer  "game_id",    :null => false
    t.string   "role"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "days", :force => true do |t|
    t.integer   "game_id"
    t.integer   "seq"
    t.timestamp "started"
    t.timestamp "ended"
    t.integer   "topic_id"
    t.integer   "last_page"
    t.integer   "last_post"
  end

  create_table "games", :force => true do |t|
    t.string  "title"
    t.integer "moderator_id"
    t.integer "server_id"
  end

  create_table "nicknames", :force => true do |t|
    t.integer "person_id"
    t.string  "nickname"
  end

  add_index "nicknames", ["nickname"], :name => "index_nicknames_on_nickname", :unique => true

  create_table "people", :force => true do |t|
    t.string "name"
  end

  add_index "people", ["name"], :name => "index_people_on_name", :unique => true

  create_table "players", :force => true do |t|
    t.integer "person_id"
    t.integer "game_id"
    t.integer "seq"
    t.string  "role"
    t.string  "alignment"
    t.string  "fate"
    t.integer "death_day_id"
  end

  add_index "players", ["person_id", "game_id"], :name => "index_players_on_person_id_and_game_id", :unique => true

  create_table "servers", :force => true do |t|
    t.string "name"
    t.string "base_url"
    t.string "username"
    t.string "password"
    t.string "xpath_to_vote"
    t.string "xpath_vote_to_user"
    t.string "xpath_vote_to_post_id"
    t.text   "cookies"
  end

  create_table "users", :force => true do |t|
    t.string   "login",                             :null => false
    t.string   "crypted_password",                  :null => false
    t.string   "password_salt",                     :null => false
    t.string   "persistence_token",                 :null => false
    t.integer  "login_count",        :default => 0, :null => false
    t.integer  "failed_login_count", :default => 0, :null => false
    t.datetime "last_request_at"
    t.datetime "current_login_at"
    t.datetime "last_login_at"
    t.string   "current_login_ip"
    t.string   "last_login_ip"
  end

  create_table "votes", :force => true do |t|
    t.integer   "day_id"
    t.integer   "seq"
    t.integer   "voter_id"
    t.integer   "target_id"
    t.string    "target_name"
    t.timestamp "cast"
    t.string    "source_post"
    t.boolean   "ignore",      :default => false
  end

end
