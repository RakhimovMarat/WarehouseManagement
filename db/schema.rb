# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2024_09_12_185437) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "addresses", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "warehouse_id", null: false
    t.index ["warehouse_id"], name: "index_addresses_on_warehouse_id"
  end

  create_table "expenses", force: :cascade do |t|
    t.bigint "address_id", null: false
    t.bigint "item_id", null: false
    t.integer "quantity", null: false
    t.string "responsible"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["address_id"], name: "index_expenses_on_address_id"
    t.index ["item_id"], name: "index_expenses_on_item_id"
  end

  create_table "items", force: :cascade do |t|
    t.string "number"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "address_id"
    t.index ["address_id"], name: "index_items_on_address_id"
  end

  create_table "receipts", force: :cascade do |t|
    t.bigint "address_id", null: false
    t.bigint "item_id", null: false
    t.integer "quantity", null: false
    t.string "responsible"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["address_id"], name: "index_receipts_on_address_id"
    t.index ["item_id"], name: "index_receipts_on_item_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "username"
    t.boolean "admin"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "warehouses", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "warehouse_code"
  end

  add_foreign_key "addresses", "warehouses"
  add_foreign_key "expenses", "addresses"
  add_foreign_key "expenses", "items"
  add_foreign_key "items", "addresses"
  add_foreign_key "receipts", "addresses"
  add_foreign_key "receipts", "items"
end
