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

ActiveRecord::Schema.define(version: 20160725043038) do

  create_table "addresses", force: :cascade do |t|
    t.string   "title",        null: false
    t.string   "receiver",     null: false
    t.string   "street",       null: false
    t.binary   "country",      null: false
    t.string   "city",         null: false
    t.string   "postal_code",  null: false
    t.string   "phone"
    t.string   "state"
    t.integer  "user_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.string   "company"
    t.string   "street_extra"
  end

  add_index "addresses", ["user_id"], name: "index_addresses_on_user_id"

  create_table "cart_items", force: :cascade do |t|
    t.integer  "quantity"
    t.integer  "product_id", null: false
    t.integer  "user_id",    null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "cart_items", ["product_id"], name: "index_cart_items_on_product_id"
  add_index "cart_items", ["user_id"], name: "index_cart_items_on_user_id"

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.integer  "category_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "sparkfun_id"
  end

  add_index "categories", ["category_id"], name: "index_categories_on_category_id"

  create_table "order_items", force: :cascade do |t|
    t.integer  "product_id"
    t.integer  "quantity"
    t.decimal  "price"
    t.integer  "order_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "order_items", ["order_id"], name: "index_order_items_on_order_id"
  add_index "order_items", ["product_id"], name: "index_order_items_on_product_id"

  create_table "orders", force: :cascade do |t|
    t.integer  "status"
    t.string   "tracking_number"
    t.integer  "user_id"
    t.integer  "address_id"
    t.integer  "shipping_method_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  add_index "orders", ["address_id"], name: "index_orders_on_address_id"
  add_index "orders", ["shipping_method_id"], name: "index_orders_on_shipping_method_id"
  add_index "orders", ["user_id"], name: "index_orders_on_user_id"

  create_table "product_pictures", force: :cascade do |t|
    t.string   "picture_file_name"
    t.string   "picture_content_type"
    t.integer  "picture_file_size"
    t.datetime "picture_updated_at"
    t.integer  "product_id"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.boolean  "default"
    t.string   "sparkfun_link"
  end

  add_index "product_pictures", ["product_id"], name: "index_product_pictures_on_product_id"

  create_table "products", force: :cascade do |t|
    t.string   "name"
    t.decimal  "price"
    t.text     "description"
    t.integer  "stock"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.integer  "category_id",       null: false
    t.string   "sku"
    t.boolean  "open_source"
    t.string   "country"
    t.integer  "pack_length"
    t.integer  "pack_width"
    t.integer  "pack_height"
    t.decimal  "weight"
    t.boolean  "backorder_allowed"
    t.integer  "sparkfun_id"
    t.boolean  "rohs"
  end

  add_index "products", ["category_id"], name: "index_products_on_category_id"

  create_table "shipping_methods", force: :cascade do |t|
    t.string   "name"
    t.decimal  "base_cost"
    t.decimal  "extra_cost_per_gram"
    t.integer  "base_cost_max_weight"
    t.integer  "delivery_time_min"
    t.integer  "delivery_time_max"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
    t.string   "email",                              default: "", null: false
    t.string   "encrypted_password",                 default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                      default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.text     "profile",                limit: 250
    t.string   "alias",                  limit: 50
    t.binary   "country"
    t.string   "company"
    t.string   "fax"
    t.string   "phone"
    t.integer  "privacy_setting"
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
