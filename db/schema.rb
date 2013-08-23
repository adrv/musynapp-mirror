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

ActiveRecord::Schema.define(version: 20130823112056) do

  create_table "bands", force: true do |t|
    t.string   "name"
    t.integer  "genre_id"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "bands_fans", force: true do |t|
    t.integer "fan_id",  null: false
    t.integer "band_id", null: false
  end

  create_table "fan_friendships", force: true do |t|
    t.integer "fan_id"
    t.integer "friend_id"
  end

  create_table "fans", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
  end

  create_table "fans_venues", force: true do |t|
    t.integer "fan_id",   null: false
    t.integer "venue_id", null: false
  end

  create_table "registrations", force: true do |t|
    t.string   "username"
    t.string   "password"
    t.string   "password_digest"
    t.datetime "dob"
    t.integer  "questionnaire_id"
    t.integer  "registrateable_id"
    t.string   "registrateable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "secret_question_answers", force: true do |t|
    t.string   "body"
    t.integer  "secret_question_id"
    t.integer  "registration_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "secret_questions", force: true do |t|
    t.string   "body"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "venues", force: true do |t|
    t.string   "name"
    t.string   "address"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
