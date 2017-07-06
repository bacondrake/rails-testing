# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20170706040323) do

  create_table "tweets", force: :cascade do |t|
    t.string "content"
    t.integer "zombie_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "weapons", force: :cascade do |t|
    t.integer "zombie_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.index ["zombie_id"], name: "index_weapons_on_zombie_id"
  end

  create_table "zombies", force: :cascade do |t|
    t.string "name"
    t.string "graveyard"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "tweet_id"
    t.integer "weapon_id"
    t.string "status"
    t.index ["tweet_id"], name: "index_zombies_on_tweet_id"
    t.index ["weapon_id"], name: "index_zombies_on_weapon_id"
  end

end
