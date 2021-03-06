# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20141002095834) do

  create_table "feed_items", force: true do |t|
    t.integer  "user_id"
    t.string   "title"
    t.string   "link"
    t.text     "description"
    t.date     "published"
    t.string   "file"
    t.string   "geo"
    t.text     "keywords"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "dc_creator"
    t.string   "itunes_author"
    t.string   "itunes_duration"
    t.boolean  "itunes_explicit"
    t.string   "itunes_keywords"
    t.string   "media_rights"
    t.string   "remote_file"
    t.string   "processed_filename"
  end

  add_index "feed_items", ["user_id"], name: "index_feed_items_on_user_id"

  create_table "users", force: true do |t|
    t.integer  "uid"
    t.string   "username"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
