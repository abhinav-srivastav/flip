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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20121219053123) do

  create_table "brands", :force => true do |t|
    t.string   "brand"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "slug"
  end

  add_index "brands", ["slug"], :name => "index_brands_on_slug", :unique => true

  create_table "brands_categories", :id => false, :force => true do |t|
    t.integer "brand_id"
    t.integer "category_id"
  end

  create_table "categories", :force => true do |t|
    t.string   "category"
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
    t.boolean  "visible",    :default => true
    t.string   "slug"
  end

  add_index "categories", ["slug"], :name => "index_categories_on_slug", :unique => true

  create_table "categories_products", :id => false, :force => true do |t|
    t.integer "category_id"
    t.integer "product_id"
  end

  create_table "line_items", :force => true do |t|
    t.integer  "product_id"
    t.integer  "quantity",                                  :default => 1
    t.decimal  "price",      :precision => 10, :scale => 2
    t.integer  "order_id"
    t.datetime "created_at",                                               :null => false
    t.datetime "updated_at",                                               :null => false
  end

  create_table "orders", :force => true do |t|
    t.integer  "user_id"
    t.decimal  "amount",          :precision => 11, :scale => 2, :default => 0.0
    t.text     "shiping_address"
    t.datetime "created_at",                                                      :null => false
    t.datetime "updated_at",                                                      :null => false
    t.string   "state"
  end

  create_table "products", :force => true do |t|
    t.string   "product"
    t.string   "product_type"
    t.decimal  "price",        :precision => 10, :scale => 2
    t.integer  "brand_id"
    t.datetime "created_at",                                  :null => false
    t.datetime "updated_at",                                  :null => false
    t.string   "slug"
  end

  add_index "products", ["slug"], :name => "index_products_on_slug", :unique => true

  create_table "users", :force => true do |t|
    t.string   "username"
    t.string   "password_digest"
    t.string   "email"
    t.boolean  "admin",                                          :default => false
    t.decimal  "wallet",          :precision => 10, :scale => 2, :default => 10000.0
    t.datetime "created_at",                                                          :null => false
    t.datetime "updated_at",                                                          :null => false
    t.boolean  "super",                                          :default => false
  end

end
