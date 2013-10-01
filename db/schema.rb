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

ActiveRecord::Schema.define(version: 20131001080546) do

  create_table "admins", force: true do |t|
  end

  create_table "bands", force: true do |t|
    t.string   "name"
    t.integer  "genre_id"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "links"
    t.boolean  "virtual",     default: false
  end

  create_table "bands_fans", force: true do |t|
    t.integer "fan_id",  null: false
    t.integer "band_id", null: false
  end

  create_table "conversations", force: true do |t|
    t.string   "subject",    default: ""
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
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
    t.string   "name"
  end

  create_table "fans_shows", force: true do |t|
    t.integer "show_id", null: false
    t.integer "fan_id",  null: false
  end

  create_table "fans_venues", force: true do |t|
    t.integer "fan_id",   null: false
    t.integer "venue_id", null: false
  end

  create_table "genres", force: true do |t|
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "images", force: true do |t|
    t.integer  "imageable_id"
    t.string   "imageable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "upload_file_name"
    t.string   "upload_content_type"
    t.integer  "upload_file_size"
    t.datetime "upload_updated_at"
    t.boolean  "primary_flag"
  end

  create_table "menus", force: true do |t|
    t.integer  "venue_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "upload_file_name"
    t.string   "upload_content_type"
    t.integer  "upload_file_size"
    t.datetime "upload_updated_at"
  end

  create_table "notifications", force: true do |t|
    t.string   "type"
    t.text     "body"
    t.string   "subject",              default: ""
    t.integer  "sender_id"
    t.string   "sender_type"
    t.integer  "conversation_id"
    t.boolean  "draft",                default: false
    t.datetime "updated_at",                           null: false
    t.datetime "created_at",                           null: false
    t.integer  "notified_object_id"
    t.string   "notified_object_type"
    t.string   "notification_code"
    t.string   "attachment"
    t.boolean  "global",               default: false
    t.datetime "expires"
  end

  add_index "notifications", ["conversation_id"], name: "index_notifications_on_conversation_id"

  create_table "receipts", force: true do |t|
    t.integer  "receiver_id"
    t.string   "receiver_type"
    t.integer  "notification_id",                            null: false
    t.boolean  "is_read",                    default: false
    t.boolean  "trashed",                    default: false
    t.boolean  "deleted",                    default: false
    t.string   "mailbox_type",    limit: 25
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
  end

  add_index "receipts", ["notification_id"], name: "index_receipts_on_notification_id"

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
    t.string   "current_step"
  end

  create_table "requests", force: true do |t|
    t.integer  "requester_id"
    t.string   "requester_type"
    t.integer  "requested_id"
    t.string   "requested_type"
    t.string   "state",           default: "proposed"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "show_id"
    t.integer  "show_address_id"
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

  create_table "shows", force: true do |t|
    t.integer  "venue_id"
    t.integer  "band_id"
    t.datetime "dt"
    t.integer  "crowd_size"
    t.text     "address"
    t.decimal  "cost",           precision: 8, scale: 2
    t.text     "description"
    t.boolean  "private"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "requested_type"
    t.boolean  "approved"
  end

  create_table "songs", force: true do |t|
    t.integer  "band_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "upload_file_name"
    t.string   "upload_content_type"
    t.integer  "upload_file_size"
    t.datetime "upload_updated_at"
    t.boolean  "primary_flag"
  end

  create_table "venues", force: true do |t|
    t.string   "name"
    t.string   "address"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "links"
    t.boolean  "virtual",     default: false
  end

  create_table "videos", force: true do |t|
    t.integer  "venue_id"
    t.string   "link"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "upload_file_name"
    t.string   "upload_content_type"
    t.integer  "upload_file_size"
    t.datetime "upload_updated_at"
  end

end
