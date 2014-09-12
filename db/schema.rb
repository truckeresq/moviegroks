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

ActiveRecord::Schema.define(version: 20140912223610) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "delayed_jobs", force: true do |t|
    t.integer  "priority",   default: 0, null: false
    t.integer  "attempts",   default: 0, null: false
    t.text     "handler",                null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree

  create_table "favorite_quotes", force: true do |t|
    t.text     "quote"
    t.string   "movie"
    t.string   "year"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "groks", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.boolean  "pitch"
    t.string   "title"
    t.integer  "theme_id"
    t.string   "audio_file_name"
    t.string   "audio_content_type"
    t.integer  "audio_file_size"
    t.datetime "audio_updated_at"
    t.string   "audio_remote_url"
    t.boolean  "authorship"
    t.boolean  "processing"
    t.integer  "movie_id"
  end

  create_table "movies", force: true do |t|
    t.string   "title"
    t.string   "movie_image_url"
    t.string   "movie_trailer_url"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "year"
  end

  create_table "profiles", force: true do |t|
    t.string   "city"
    t.string   "state"
    t.string   "website"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image"
  end

  create_table "subscriptions", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "themes", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "keyword"
  end

  add_index "themes", ["keyword"], name: "index_themes_on_keyword", unique: true, using: :btree

  create_table "users", force: true do |t|
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "admin",                  default: false
    t.string   "auth_token"
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.string   "first_name"
    t.string   "last_name"
  end

  create_table "votes", force: true do |t|
    t.boolean  "vote",          default: false, null: false
    t.integer  "voteable_id",                   null: false
    t.string   "voteable_type",                 null: false
    t.integer  "voter_id"
    t.string   "voter_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "votes", ["voteable_id", "voteable_type"], name: "index_votes_on_voteable_id_and_voteable_type", using: :btree
  add_index "votes", ["voter_id", "voter_type", "voteable_id", "voteable_type"], name: "fk_one_vote_per_user_per_entity", unique: true, using: :btree
  add_index "votes", ["voter_id", "voter_type"], name: "index_votes_on_voter_id_and_voter_type", using: :btree

end
