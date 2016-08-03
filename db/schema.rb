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

ActiveRecord::Schema.define(version: 20160803133733) do

  create_table "comments", force: :cascade do |t|
    t.text     "body"
    t.integer  "user_id"
    t.integer  "post_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "comments", ["post_id"], name: "index_comments_on_post_id"
  add_index "comments", ["user_id"], name: "index_comments_on_user_id"

  create_table "drawmsgs", force: :cascade do |t|
    t.text     "content"
    t.integer  "receiver_id"
    t.integer  "user_id"
    t.integer  "status",      default: 0
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "drawmsgs", ["user_id"], name: "index_drawmsgs_on_user_id"

  create_table "draws", force: :cascade do |t|
    t.integer  "post_id"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "draws", ["post_id"], name: "index_draws_on_post_id"
  add_index "draws", ["user_id"], name: "index_draws_on_user_id"

  create_table "folders", force: :cascade do |t|
    t.string   "title"
    t.text     "about"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "folders", ["user_id"], name: "index_folders_on_user_id"

  create_table "likes", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "post_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "likes", ["post_id"], name: "index_likes_on_post_id"
  add_index "likes", ["user_id"], name: "index_likes_on_user_id"

  create_table "messages", force: :cascade do |t|
    t.string   "title"
    t.text     "body"
    t.integer  "sender_id"
    t.integer  "receiver_id"
    t.integer  "status",      default: 0
    t.integer  "types",       default: 0
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "posts", force: :cascade do |t|
    t.string   "title"
    t.string   "image"
    t.text     "content"
    t.integer  "folder_id",  default: 0
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "user_id"
    t.integer  "view",       default: 0
  end

  add_index "posts", ["user_id"], name: "index_posts_on_user_id"

  create_table "relationships", force: :cascade do |t|
    t.integer  "follower_id"
    t.integer  "following_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "relationships", ["follower_id"], name: "index_relationships_on_follower_id"
  add_index "relationships", ["following_id", "follower_id"], name: "index_relationships_on_following_id_and_follower_id", unique: true
  add_index "relationships", ["following_id"], name: "index_relationships_on_following_id"

  create_table "taggings", force: :cascade do |t|
    t.integer  "tag_id"
    t.integer  "post_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "taggings", ["post_id"], name: "index_taggings_on_post_id"
  add_index "taggings", ["tag_id"], name: "index_taggings_on_tag_id"

  create_table "tags", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "avatar"
    t.integer  "role",            default: 0
    t.string   "password_digest"
    t.text     "about"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.integer  "view",            default: 0
    t.string   "category"
    t.integer  "logincount",      default: 0
  end

end
