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

ActiveRecord::Schema.define(:version => 20100510162014) do

  create_table "day_threads", :force => true do |t|
    t.integer "day_id"
    t.integer "topic_id"
    t.integer "last_page"
    t.integer "last_post"
  end

  create_table "days", :force => true do |t|
    t.integer  "game_id"
    t.integer  "seq"
    t.datetime "started"
    t.datetime "ended"
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

  create_table "people", :force => true do |t|
    t.string "name"
  end

  create_table "players", :force => true do |t|
    t.integer "person_id"
    t.integer "game_id"
    t.integer "seq"
    t.string  "role"
    t.string  "alignment"
    t.string  "fate"
    t.integer "death_day_id"
  end

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

  create_table "votes", :force => true do |t|
    t.integer  "day_id"
    t.integer  "seq"
    t.integer  "voter_id"
    t.integer  "target_id"
    t.string   "target_name"
    t.datetime "cast"
    t.string   "source_post"
  end

end
