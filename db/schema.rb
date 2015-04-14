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

ActiveRecord::Schema.define(version: 20150414223854) do

  create_table "admin_menus", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.string   "summary"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "menu_id"
  end

  add_index "categories", ["menu_id"], name: "index_categories_on_menu_id"

  create_table "comments", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "item_id"
    t.integer  "user_id"
    t.text     "body"
    t.string   "ancestry"
  end

  add_index "comments", ["ancestry"], name: "index_comments_on_ancestry"
  add_index "comments", ["item_id"], name: "index_comments_on_item_id"
  add_index "comments", ["user_id"], name: "index_comments_on_user_id"

  create_table "cores", force: :cascade do |t|
    t.text     "twitter"
    t.text     "github"
    t.text     "email"
    t.boolean  "show_icons"
    t.boolean  "show_login"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "items", force: :cascade do |t|
    t.string   "title"
    t.text     "content"
    t.string   "summary"
    t.integer  "category_id"
    t.integer  "user_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "items", ["category_id"], name: "index_items_on_category_id"
  add_index "items", ["user_id"], name: "index_items_on_user_id"

  create_table "menus", force: :cascade do |t|
    t.string   "title"
    t.boolean  "visible"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "static_pages", force: :cascade do |t|
    t.string   "title"
    t.text     "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email"
    t.string   "encrypted_password"
    t.string   "password_salt"
    t.integer  "sign_in_count"
    t.integer  "failed_attempts"
    t.datetime "last_request_at"
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "display_name"
    t.text     "biography"
    t.string   "website"
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.string   "confirmation_token",     limit: 255
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.string   "remember_token",         limit: 255
    t.datetime "remember_created_at"
    t.string   "unlock_token",           limit: 255
    t.datetime "locked_at"
    t.string   "provider"
    t.string   "uid"
    t.integer  "roles_mask"
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  add_index "users", ["unlock_token"], name: "index_users_on_unlock_token", unique: true

end
