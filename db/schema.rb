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

ActiveRecord::Schema.define(version: 20171219025108) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "daily_goals", force: :cascade do |t|
    t.bigint "goal_id"
    t.date "goal_date"
    t.decimal "value"
    t.json "seller_ids"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["goal_id"], name: "index_daily_goals_on_goal_id"
  end

  create_table "goals", force: :cascade do |t|
    t.bigint "store_id"
    t.string "name"
    t.date "start_date"
    t.date "end_date"
    t.decimal "total_value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["store_id"], name: "index_goals_on_store_id"
  end

  create_table "owners", force: :cascade do |t|
    t.string "name"
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_owners_on_email", unique: true
    t.index ["reset_password_token"], name: "index_owners_on_reset_password_token", unique: true
  end

  create_table "sellers", force: :cascade do |t|
    t.string "registration"
    t.string "name"
    t.bigint "owner_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["owner_id"], name: "index_sellers_on_owner_id"
  end

  create_table "store_sellers", id: false, force: :cascade do |t|
    t.bigint "store_id"
    t.bigint "seller_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["seller_id"], name: "index_store_sellers_on_seller_id"
    t.index ["store_id"], name: "index_store_sellers_on_store_id"
  end

  create_table "stores", force: :cascade do |t|
    t.string "name"
    t.bigint "owner_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["owner_id"], name: "index_stores_on_owner_id"
  end

  add_foreign_key "daily_goals", "goals"
  add_foreign_key "goals", "stores"
  add_foreign_key "sellers", "owners"
  add_foreign_key "store_sellers", "sellers"
  add_foreign_key "store_sellers", "stores"
  add_foreign_key "stores", "owners"
end
